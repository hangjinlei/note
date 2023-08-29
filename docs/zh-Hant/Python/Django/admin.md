# Admin

## Create Django Super User

```bash
python manage.py createsuperuser
```

setup username, email, password

## Register Model to Admin Panel

register model in `<app>/admin.py`

Then you can see the model in admin panel: http://localhost:8000/admin/

```python
from .models import model_name
admin.site.register(model_name)
```
