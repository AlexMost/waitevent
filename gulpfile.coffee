gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
nodeunit = require  'gulp-nodeunit'
nodemon = require 'gulp-nodemon'

SRC_PATH = './src/**/*.coffee'
SRC_EJS_PATH = './src/**/*.ejs'
SRC_TEST_PATH = './test/**/*.coffee'
TEST_PATH = './testbuild/**/*.js'


gulp.task 'default', ->
    gulp.src(SRC_PATH)
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
    gulp.src(SRC_EJS_PATH).pipe(gulp.dest('./build'))


gulp.task 'test', ['testbuild'], ->
    gulp.src(TEST_PATH)
        .pipe(nodeunit({reporter: "default"}))


gulp.task 'build', ['default', 'ejs']


gulp.task 'dev', ['build'], ->
    nodemon(
        script: './build/server/server.js'
        ext: 'js'
        env:
            NODE_ENV: 'development')
    .on('start', ['watch_src'])
    .on('change', ['watch_src'])


# Watchers
gulp.task 'watch_src', ->
    gulp.watch SRC_PATH, ['build']


gulp.task 'watch_test', ->
    gulp.watch SRC_TEST_PATH, ['test']