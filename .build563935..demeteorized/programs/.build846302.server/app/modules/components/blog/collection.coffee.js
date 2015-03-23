(function(){__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
this.Blog = new Mongo.Collection('blog');

this.BlogTags = new Mongo.Collection('blogTags');

this.BlogCategories = new Mongo.Collection('blogCategories');

AuraColl['blog'] = Blog;

AuraColl['blogTags'] = BlogTags;

AuraColl['blogCategories'] = BlogCategories;

})();

//# sourceMappingURL=collection.coffee.js.map
