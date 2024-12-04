# Form

## Usage

also need to set route in `urls.py`

### Create

create a model form inherit from `ModelForm` in `<app>/forms.py`

`<app>/forms.py`

```python
from django.forms import ModelForm
from .models import Room


class RoomForm(ModelForm):
    class Meta:
        model = Room
        fields = '__all__'
```

`<app>/views.py`

because of the RoomForm is inherit from ModelForm, so we can use the `form.save()` to save the form data to database.

```python
from django.shortcuts import render
from .forms import RoomForm


def createRoom(requset: HttpRequest):
    form = RoomForm()

    if requset.method == "POST":
        form = RoomForm(requset.POST)
        if form.is_valid():
            form.save()
            return redirect(to=home)

    context = {"form": form}
    return render(request=requset, template_name='base/room_form.html', context=context)
```

`<app>/templates/<app>/room_form.html`

this can be used for both create and update.

```python
{% extends 'main.html' %}
{% block content %}
<div>
    <form method="POST" action="">
        {% csrf_token %}
        {{form.as_p }}
        <input type="submit" value="Submit" />
    </form>
</div>
{% endblock content %}
```

### Update

`<app>/views.py`

```python
def updateRoom(request: HttpRequest, pk: str):
    room = Room.objects.get(id=int(pk))
    form = RoomForm(instance=room)

    if request.method == "POST":
        form = RoomForm(request.POST, instance=room)
        if form.is_valid():
            form.save()
            return redirect(to=home)

    context = {'form': form}
    return render(request=request, template_name="base/room_form.html", context=context)
```

### Delete

`<app>/templates/<app>/delete.html`

```python
{% extends 'main.html' %} {% block content %}
<form method="POST" action="">
  {% csrf_token %}
  <p>Are you sure you want to delete "{{obj}}"?</p>

  <a href="{{request.META.HTTP_REFERER}}">Go Back</a>
  <input type="submit" value="Confirm" />
</form>
{% endblock content %}
```

`<app>/views.py`

```python
def deleteRoom(request: HttpRequest, pk: str):
    room = Room.objects.get(id=pk)
    if request.method == "POST":
        room.delete()
        return redirect(to=home)

    context = {"obj": room}
    return render(request=request, template_name="base/delete.html", context=context)
```
