# Getting Started

- [Getting Started](#getting-started)
  - [参考](#参考)
  - [要点](#要点)
  - [待测试方法](#待测试方法)
  - [测试用例](#测试用例)
  - [测试套件](#测试套件)

## 参考

- [Ruby Programming/Unit testing - Wikibooks, open books for an open world](https://en.wikibooks.org/wiki/Ruby_Programming/Unit_testing)
- [Module: Test::Unit (Ruby 3.1.2)](https://ruby-doc.org/stdlib-3.1.2/libdoc/test-unit/rdoc/Test/Unit.html)

## 要点

- 使用概要

  1. 导入 `test/unit`
  2. 继承 `Test::Unit::TestCase`

     ```ruby
     require 'test/unit'

     class Apple
       def color
         'red'
       end
     end

     class AppleTest< Test::Unit::TestCase
       def test_color
         assert Apple.new.color == 'red'
       end
     end
     ```

- 命名规范

  The author of Test::Unit, Nathaniel Talbott, suggests starting the names of **_test cases_** with **\_tc\_\_** and the names of **_test suites_** with **\_ts\_\_**

## 待测试方法

- simple_number.rb

  ```ruby
  class SimpleNumber
      def initialize(num)
          # raise unless num.is_a?(Numeric)
          @x = num
      end

      def add(y)
          @x + y
      end

      def multiply(y)
          @x * y
      end
  end
  ```

## 测试用例

- tc_simple_number.rb

  ```ruby
  require_relative "simple_number"
  require "test/unit"

  class TestSimpleNumber < Test::Unit::TestCase

      def test_simple
          assert_equal(4, SimpleNumber.new(2).add(2) )
          assert_equal(6, SimpleNumber.new(2).multiply(3) )
      end

  end
  ```

## 测试套件

测试套件可以导入多个测试用例，然后执行。

- ts_all_the_tests.rb

  ```ruby
  require 'test/unit'
  require_relative("./tc_simple_number")
  require_relative("./tc_simple_number2")
  ```
