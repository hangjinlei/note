# ApplicationRecord

方法

- `validates_presence_of` 必填
  - `on`
  - `message`
- `validates_uniqueness_of` 唯一
  - `on`
  - `message`
  - `:scope`
- `belongs_to` 外键表
- `has_many` 主键表
- `before_validation`
  - `on`

示例

```ruby
class Reservation < ApplicationRecord
  validates_presence_of :train_id, :seat_number, :booking_code
  validates_uniqueness_of :seat_number, :scope => :train_id

  belongs_to :train

  before_validation :generate_booking_code, on: :create

  def generate_booking_code
    self.booking_code = SecureRandom.uuid
  end
end
```
