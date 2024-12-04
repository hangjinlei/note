# Models

## Django models cheat sheet

- [Model field reference | Django documentation | Django](https://docs.djangoproject.com/en/4.1/ref/models/fields/#model-field-types)

| Model Field     | Use           | Sensible defaults                         |
| :-------------- | :------------ | :---------------------------------------- |
| `CharField`     | Small text    | `blank=False, null=False, max_length=150` |
| `TextField`     | Large text    | `blank=False, null=False, max_length=150` |
| `BooleanField`  | Flags         | `default=False`                           |
| `DateField`     | Dates         | `auto_now_add=True`                       |
| `DateTimeField` | Date and Time | `auto_now_add=True`                       |
| `EmailField`    | Small text    | `blank=False, null=False`                 |
| `URLField`      | Small text    | `blank=False, null=False`                 |
| `IntegerField`  | Numbers       | `blank=False, null=False`                 |
| `SlugField`     | Slug strings  | `blank=False, null=False`                 |
| `ImageField`    | Image uploads | `null=False`                              |
| `FileField`     | File uploads  | `upload_to='uploads/'`                    |
| `FilePathField` | File paths    | `path='/path/to/'`                        |

## Models Example

```python
from django.db import models
from django.urls import reverse
# Create your models here.


class Destination(models.Model):
    name = models.CharField(unique=True, null=False,
                            blank=False, max_length=50)

    description = models.TextField(max_length=2000, null=False, blank=False)
    slug = models.SlugField()

    def __str__(self) -> str:
        return self.name

    def get_absolute_url(self):
        return reverse("destination_detail", kwargs={"pk": self.pk})


class Cruise(models.Model):
    name = models.CharField(unique=True, null=False,
                            blank=False, max_length=50)

    description = models.TextField(max_length=2000, null=False, blank=False)
    destinations = models.ManyToManyField(
        Destination, related_name='destinations')

    def __str__(self) -> str:
        return self.name


class InfoRequest(models.Model):
    name = models.CharField(max_length=50, null=False, blank=False,)
    email = models.EmailField()
    notes = models.TextField(max_length=2000, null=False, blank=False)
    cruise = models.ForeignKey(Cruise, on_delete=models.PROTECT)
```

### Using the database

Import the model

```bash
from relecloud.models import Destination
```

Create a new object

```bash
mars = Destination(name='Mars', description='The red planet', slug='mars')
mars.save()
```

Get all objects in the database

```bash
all_destinations = Destination.objects.all()
```

Get a specific object

```bash
mars = Destination.objects.get(name='Mars')
```

Update it

```bash
mars.description = 'The red planet'
mars.save()
```

## Migration

### Create

run the following command to create a migration file.

```bash
python manage.py makemigrations
```

### Migrate

run the following command to migrate the database.

```bash
python manage.py migrate
```

## Related to User

We need to import the `User` model from `django.contrib.auth.models` first,

then set user as a foreign key.

```python
from django.contrib.auth.models import User
from django.db import models

class model(models.Model):
    user = models.ForeignKey(to=User, on_delete=models.CASCADE)
```

## Order by

if we use `-` before the field name, it will be descending order.

```python
class Room(models.Model):
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["-updated", "-created"]

    def __str__(self) -> str:
        return str(self.name)
```
