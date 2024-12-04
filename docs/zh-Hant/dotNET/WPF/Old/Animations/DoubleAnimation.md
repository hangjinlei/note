# Double Animation

namespace: `System.Windows.Media.Animation`

- 创建一个新的 DoubleAnimation

  ```csharp
  var animation = new DoubleAnimation();
  ```

- 使用 By 或 (From and To) 指定每次变化的值

  ```csharp
  animation.By = -30; // By is the amount to increase the value by
  ```

  OR

  ```csharp
  animation.From = btn.Width; // From is the starting value
  animation.To = btn.Width - 30; // To is the ending value
  ```

- 设置 Duration

  ```csharp
  animation.Duration = TimeSpan.FromSeconds(2); // Duration is the time it takes to complete the animation
  ```

- 设置 AutoReverse

  ```csharp
  animation.AutoReverse = true; // if true, the animation will reverse after it finishes
  ```

- 设置 RepeatBehavior

  ```csharp
  animation.RepeatBehavior = RepeatBehavior.Forever;
  ```

  OR

  ```csharp
  animation.RepeatBehavior = new RepeatBehavior(2); // RepeatBehavior is the number of times the animation will repeat
  ```

- 开始动画

  ```csharp
  btn.BeginAnimation(Button.WidthProperty, animation);
  ```
