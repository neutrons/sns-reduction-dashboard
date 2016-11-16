# Django

- High-level Python Web Framework
- Quickly Develop Applications 
- Built-In Security:
  - Cross-Site Request Forgery (CSRF) 
  - Cross site scripting (XSS)
  - SQL injection protection
  - etc...
- Scalable
- Built-In Administrative Interface

## MVC vs MTV

- Model = Model
- View = Template
- Controller = View

## Default Django

- Model 
- Server serves data populated HTML.

![](https://i.stack.imgur.com/NLlwq.png)

Picture here

# Django + REST Framework

Picture here

## Class based models

```python

# Model
class Post(models.Model):
    title = models.CharField(max_length=225)
    content = models.TextField(max_length=10000)
    published = models.BooleanField(default=False)
    created_date = models.DateTimeField(auto_now_add=True)
    modified_date = models.DateTimeField(auto_now=True)

# View
class PostList(ListView):
    model = Post
    # optional. Default: <myapp>/<model>_list.html
    template_name = 'blog/post_list.html'
    # optional. Default: Post.objects.all()
    queryset = Post.objects.order_by('-modified_date')
```

## Serializers

```python

# Serializer
class PostSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
		model = Post
		fields = ('title', 'content', 'category', 'modified_date', 'url')
		# fields = '__all__'


# View
class PostViewSet(viewsets.ModelViewSet):
	queryset = Post.objects.all()
	serializer_class = PostSerializer
  
```


## A single-page application (SPA)

```html
<!DOCTYPE html>
<html lang="en">
  <head>
  </head>
  <body>
    <div id="app"></div>
    <script src="/dist/build.js"></script>  
  </body>
</html>
```

See "I am a fast webpage, kneel before my greatness": https://varvy.com/pagespeed/wicked-fast.html

Easy integration with Electron: 

## Bundler: WebPack

![webpack](https://webpack.github.io/assets/what-is-webpack.png)


## Javascript Framework: VueJs

See Example:
https://jsfiddle.net/ricleal/ptg5s4hv/2/


## Postgres >= 9.4 jsonb (Django >= 1.9 JSONField):

- Allows storing form content in JSON format
- NoSQL Functionality

```python

class Configuration(models.Model):

    title = models.CharField(
        'configuration title',
        help_text='The title of the configuration',
        max_length=128,
    )

    created_date = models.DateTimeField(
        'configuration creation date',
        help_text='The date this configuration was created',
        auto_now_add=True,
    )

    modified_date = models.DateTimeField(
        'configuration modification date',
        help_text='The date this configuration was last modified',
        auto_now=True,
    )

    parameters = pgfields.JSONField(
        'configuration parameters',
        help_text='The parameters for the configuration',
        default=dict,
    )
```

Query example:

```python
foo = Configuration.objects.filter(params__transmission >= 0.5)
```



REST API
Django + REST Framework
Postgres >= 9.4 jsonb (Django >= 1.9 JSONField):
Allows storing form content in JSON format
NoSQL Functionality
Docker containers

## Table reduction

Excel table...

