@Blog = new Mongo.Collection 'blog'
@BlogTags = new Mongo.Collection 'blogTags'
@BlogCategories = new Mongo.Collection 'blogCategories'

AuraColl['blog'] = Blog
AuraColl['blogTags'] = BlogTags
AuraColl['blogCategories'] = BlogCategories