# SilverStripe Elemental Blog Teaser Block

A block that displays blog teasers/summaries.  
(private project, no help/support provided)

## Requirements

Required Silverstripe Modules:

* SilverStripe CMS ^4.3
* dnadesign/silverstripe-elemental ^4.0
* sheadawson/silverstripe-linkable ^2.0@dev
* sheadawson/silverstripe-dependentdropdownfield ^2@dev
* silverstripe/blog ^3@dev
* jonom/focuspoint ^3.0

For a SilverStripe 4.2 and Elemental 3.x compatible version of this module, please see the [1.x release line](https://github.com/derralf/silverstripe-elemental-blog-teaser/tree/1.0#readme).

Required Javascript Libs (when using default template/Script):

* imagesloaded
* isotope


## Suggestions
* derralf/elemental-styling

Modify `/templates/Derralf/Elements/TextImages/Includes/Title.ss` to your needs when using StyledTitle from derralf/elemental-styling.


## Configuration

A basic/default config. Add this to your **mysite/\_config/elements.yml**

```

---
Name: elementalblogteaser
---
Derralf\Elements\ElementBlogTeaser\Element\ElementBlogTeaser:
  styles:
    ContainerBreakout: '3 Columns with well and Container-Breakout'
    FeaturedBigOtherSmall: '1 big featured Post, others small (with Container-Breakout)'
  styles_default_description: 'Standard: 3 columns with isotope-selectors'
  readmore_link_class: 'btn btn-primary btn-readmore'

```

Additionally you may apply the default styles:

```
# add default styles
DNADesign\Elemental\Controllers\ElementController:
  default_styles:
   - derralf/elemental-blog-teaser:client/dist/styles/frontend-default.css
```


## Template Notes

The default Template uses [Isotope](https://isotope.metafizzy.co/) with [Imagesloaded](https://imagesloaded.desandro.com/[](``))

Optionaly, you can require basic CSS stylings and Javascript provided with this module to your controller class like:
  **mysite/code/PageController.php**

```
Requirements::css('derralf/elemental-blog-teaser:client/dist/styles/frontend-default.css');
Requirements::javascript('derralf/elemental-blog-teaser:client/dist/js/isotope.init.js');
```

If you use default template and script and haven't already included [Isotope](https://isotope.metafizzy.co/) and [Imagesloaded](https://imagesloaded.desandro.com/[](``)) you may requir the libraries in your mysite/code/PageController.php **before** the above shown default javascript:

```
Requirements::javascript('https://unpkg.com/isotope-layout@3/dist/isotope.pkgd.min.js');
Requirements::javascript('https://unpkg.com/imagesloaded@4/imagesloaded.pkgd.min.js');
```

### More icons for FlexListItem.ss
For `FeaturedBigOtherSmall` see also [FlexListItem-advanced-example.ss](templates/Derralf/Elements/ElementBlogTeaser/Includes/FlexListItem-advanced-example.ss) wich needs some extra template images and blog tweaking.  
Copy over and rename to /themes/[YOURTHEME]/templates/Derralf/Elements/ElementBlogTeaser/Includes/FlexListItem.ss


## Hooks

If you want to add additional filtering/sorting you can use the Extension Hook `updateBlogPosts` in an extension like this:

```
<?php

namespace App\Extension;

use SilverStripe\ORM\DataExtension;

class ElementBlogTeaserExtension extends DataExtension
{
    public function updateBlogPosts(&$posts) {
        // example: only posts with image
        $posts = $posts->filter(['FeaturedImageID:GreaterThan' => 1]);
        // example: custom sorting
        $posts = $posts->sort('PublishDate ASC');
    }
}

```

... and in your **mysite/\_config/elements.yml** add:

```
Derralf\Elements\ElementBlogTeaser\Element\ElementBlogTeaser:
  extensions:
    - App\Extension\ElementBlogTeaserExtension
```
