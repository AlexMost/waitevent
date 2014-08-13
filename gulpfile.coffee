gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
nodeunit = require  'gulp-nodeunit'
nodemon = require 'gulp-nodemon'
browserify = require 'gulp-browserify'

SRC_SERVER_PATH = './src/**/*.coffee'
SRC_CLIENT_PATH = ['./src/client/**/*.coffee',
                   './src/components/**/*.coffee']
SRC_EJS_PATH = './src/server/**/*.ejs'
SRC_TEST_PATH = './test/**/*.coffee'
TEST_PATH = './testbuild/**/*.js'


# ============= Server side tasks =============
gulp.task 'default', ->
    gulp.src(SRC_SERVER_PATH)
        .pipe(coffeelint())
        .pipe(coffeelint.reporter())
        .pipe(coffee({bare: true}).on('error', gutil.log))
        .pipe(gulp.dest('./build'))


gulp.task 'testbuild', ->
    gulp.src(SRC_TEST_PATH)
        .pipe(coffeelint())
        .pipe(coffeelint.reporter())
        .pipe(coffee({bare: true}).on('error', gutil.log))
        .pipe(gulp.dest('./testbuild'))


gulp.task 'ejs', ->
    gulp.src(SRC_EJS_PATH).pipe(gulp.dest('./build/server/'))


gulp.task 'test', ['testbuild'], ->
    gulp.src(TEST_PATH)
        .pipe(nodeunit({reporter: "default"}))


gulp.task 'buildall', ['default', 'ejs', 'csbuild']


gulp.task 'dev', ['buildall'], ->
    nodemon(
        script: './build/server/server.js'
        ext: 'js'
        env:
            NODE_ENV: 'development')


# ============= client-side build tasks =============
gulp.task 'welcome_page_build', ["default"], ->
    gulp.src('./build/client/welcome_page.js', {read: false})
        .pipe(browserify())
        .pipe(gulp.dest('./build/server/public/js'))


gulp.task 'csbuild', ['welcome_page_build']


# ============= Watchers =============
gulp.task 'watch', ->
    gulp.watch SRC_SERVER_PATH, ['buildall']


gulp.task 'watch_client', ->
    gulp.watch SRC_CLIENT_PATH, ['csbuild']


gulp.task 'watch_test', ->
    gulp.watch SRC_TEST_PATH, ['test']