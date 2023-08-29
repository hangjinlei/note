# Template

```python
{% include "header.html" %}
{% block content %}
{% endblock %}
{% include "footer.html" %
```

## include

- `{% include "header.html" %}` 引用其他模板

## block

- `{% block content %} {% endblock %}` 包裹内容, 填充内容

## url

- `{% url 'room' room.id %}` 生成 url, 例如 `/room/1/`, `room` 为 url 名称, `room.id` 为参数

## 项目模板和应用模板

- 项目模板应位于 `templates` 目录下, 例如 `templates/header.html`。
- 应用模板应位于应用目录下, 例如 `blog/templates/blog/header.html`。需要注意 templates 目录下需要包含一个应用名的文件夹
