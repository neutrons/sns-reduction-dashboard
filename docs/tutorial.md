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


`package.json`
```json
{
  "name": "sns_dashboard",
  "description": "A dashboard for SNS",
  "devDependencies": {
    "assets-webpack-plugin": "^3.4.0",
    "babel-core": "^6.0.0",
    "babel-loader": "^6.0.0",
    "babel-plugin-transform-runtime": "^6.9.0",
    "babel-preset-es2015": "^6.0.0",
    "bootstrap": "^3.3.6",
    "bootstrap-webpack": "0.0.5",
    "cross-env": "^1.0.6",
    "css-loader": "^0.23.1",
    "exports-loader": "^0.6.3",
    "expose-loader": "^0.7.1",
    "extract-text-webpack-plugin": "^1.0.1",
    "file-loader": "^0.8.5",
    "handsontable": "^0.26.0",
    "imports-loader": "^0.6.5",
    "jquery": "^3.1.0",
    "jshint": "^2.9.2",
    "less": "^2.7.1",
    "less-loader": "^2.2.3",
    "style-loader": "^0.13.1",
    "url-loader": "^0.5.7",
    "vue-clickaway": "^1.1.1",
    "vue-cookie": "^1.0.0",
    "vue-focus": "^0.1.1",
    "vue-form-generator": "^0.5.0",
    "vue-hot-reload-api": "^1.3.3",
    "vue-html-loader": "^1.2.3",
    "vue-loader": "^8.5.2",
    "vue-resource": "^0.9.3",
    "vue-router": "^0.7.13",
    "vue-style-loader": "^1.0.0",
    "vuex": "^1.0.0-rc.2",
    "vuex-router-sync": "^2.0.2",
    "webpack": "^1.13.1",
    "webpack-bundle-tracker": "0.0.93",
    "webpack-dev-server": "^1.14.1"
  },
  "babel": {
    "presets": [
      "es2015"
    ]
  }
}
```

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

## Table reduction

See:
https://github.com/ricleal/PythonCode/blob/master/SANS/TableReduction/SANS%20Lysozyme.ipynb

![](https://s14.postimg.org/drbrur98x/image003.jpg)

