# RSpec

## 参考

[Let and let!](https://relishapp.com/rspec/rspec-core/v/2-11/docs/helper-methods/let-and-let)

> Use let to define a memoized helper method. The value will be cached
> across multiple calls in the same example but not across examples.
>
> Note that let is lazy-evaluated: it is not evaluated until the first time
> the method it defines is invoked. You can use let! to force the method's
> invocation before each example.
