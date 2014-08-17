gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
nodemon = require 'gulp-nodemon'
browserify = require 'gulp-browserify'
react = require 'gulp-react'
concat = require 'gulp-concat'
literalify = require 'literalify'
stylus = require 'gulp-stylus'

SRC_SERVER_PATH = './src/**/*.coffee'
SRC_CLIENT_PATH = ['./src/client/**/*.coffee',
                   './src/components/**/*.coffee']
SRC_JSX_PATH = './src/**/*.jsx'
SRC_EJS_PATH = './src/server/**/*.ejs'
SRC_TEST_PATH = './test/**/*.coffee'
TEST_PATH = './testbuild/**/*.js'
SRC_STYLYS_PATH = './styles/**/*.styl'


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


gulp.task 'build', ['default', 'ejs', 'csbuild']


gulp.task 'buildall', ['build', 'common']


gulp.task 'dev', ['watch'], ->
    nodemon(
        script: './build/server/server.js'
        ext: 'js'
        env:
            NODE_ENV: 'development')


# ============= client-side build tasks =============
browserify_common_config =
    transform: literalify.configure({react: "window.React"})

gulp.task 'welcome_page_build', ["default"], ->
    gulp.src('./build/client/welcome_page.js', {read: false})
        .pipe(browserify(browserify_common_config))
        .pipe(gulp.dest('./public/js'))


gulp.task 'create_event_page_build', ["default"], ->
    gulp.src('./build/client/create_event_page.js', {read: false})
        .pipe(browserify(browserify_common_config))
        .pipe(gulp.dest('./public/js'))


gulp.task 'event_view_page_build', ["default"], ->
    gulp.src('./build/client/event_view_page.js', {read: false})
        .pipe(browserify(browserify_common_config))
        .pipe(gulp.dest('./public/js'))


gulp.task 'jsx', ->
    gulp.src(SRC_JSX_PATH)
        .pipe(react())
        .pipe(gulp.dest('./build'))

gulp.task 'csbuild', [
    'styles'
    'jsx'
    'welcome_page_build'
    'create_event_page_build'
    'event_view_page_build'
]
# ============= common libs ==========================
COMMON_JS_LIBS = [
    "./bower_components/react/react-with-addons.js"
    "./bower_components/jquery/dist/jquery.js"
    "./bower_components/moment/moment.js"
    "./bower_components/bootstrap/dist/js/bootstrap.js"
    "./bower_components/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"
]


COMMON_CSS = [
    "./bower_components/bootstrap/dist/css/bootstrap.css"
    "./bower_components/eonasdan-bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.css"
]


gulp.task 'common-js', ->
    gulp.src(COMMON_JS_LIBS)
        .pipe(concat('common.js'))
        .pipe(gulp.dest('./public/js/'))


gulp.task 'common-css', ->
    gulp.src(COMMON_CSS)
        .pipe(concat('common.css'))
        .pipe(gulp.dest('./public/css/'))


gulp.task 'common', ['common-js', 'common-css']

# ============= Styles =============
gulp.task 'styles', ->
    gulp.src(SRC_STYLYS_PATH)
        .pipe(stylus())
        .pipe(gulp.dest('./public/css/'))


# ============= Watchers =============
gulp.task 'watch', ['build'], ->
    gulp.watch [SRC_SERVER_PATH, SRC_JSX_PATH, SRC_EJS_PATH], ['build']
    gulp.watch SRC_STYLYS_PATH, ['styles']