gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
nodeunit = require  'gulp-nodeunit'

SRC_PATH = './src/**/*.coffee'
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


gulp.task 'test', ['testbuild'], ->
    gulp.src(TEST_PATH)
        .pipe(nodeunit({reporter: "default"}))


gulp.task 'watch', ->
    gulp.watch SRC_PATH, ['default']
    gulp.watch SRC_TEST_PATH, ['test']