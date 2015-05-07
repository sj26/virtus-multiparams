# Virtus::Multiparams

Support for Rails-style multiparameters, which makes `datetime_select` [and
friends](http://api.rubyonrails.org/classes/ActionView/Helpers/DateHelper.html)
work with [Virtus](https://github.com/solnic/virtus) objects.

Rails Date, Time and DateTime selectors all use multiparameters. This means
they break one attribute into separate parameters for each input, like year,
month and day, and reconstitute these multiple parameters into a single
parameter to be passed back into a model as an attribute.

## Usage

```ruby
class PostForm
  include Virtus
  include Virtus::Multiparams

  attribute :title, String
  attribute :publish_at, DateTime
end

# app/views/posts/new.html.erb
<%= form_for @post_form do |form| %>
  <%= form.label :title %>
  <%= form.text_field :title %>

  <%= form.label :publish_at %>
  <%= form.datetime_select :publish_at %>
  <!-- Which does something like:
    <select name="post_form[publish_at(i1)]"><option>2015</option>...</select>
    <select name="post_form[publish_at(i2)]"><option value="1">January</option>...<option value="12">December</option></select>
    <select name="post_form[publish_at(i3)]"><option>1</option>...</select>
    <select name="post_form[publish_at(i4)]"><option>1</option>...<option>24</option></select>
    <select name="post_form[publish_at(i5)]"><option>1</option>...<option>60</option></select>
    <select name="post_form[publish_at(i6)]"><option>1</option>...<option>60</option></select>
  -->

  <%= form.submit %>
<% end %>

# app/controllers/posts_controller.rb
class PostsController
  def new
    @post_form = PostForm.new
  end

  def create
    @post_form = PostForm.new(params[:post_form])
    # ...
  end
end
```
