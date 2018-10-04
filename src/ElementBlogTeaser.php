<?php

namespace Derralf\Elements\ElementBlogTeaser\Element;


use DNADesign\Elemental\Models\BaseElement;
use Sheadawson\DependentDropdown\Forms\DependentDropdownField;
use Sheadawson\Linkable\Forms\LinkField;
use Sheadawson\Linkable\Models\Link;
use SilverStripe\Blog\Model\Blog;
use SilverStripe\Blog\Model\BlogCategory;
use SilverStripe\Blog\Model\BlogPost;
use SilverStripe\Core\Config\Config;

class ElementBlogTeaser extends BaseElement
{
    public function getType()
    {
        return self::$singular_name;
    }

    private static $icon = 'font-icon-block-file-list';

    private static $table_name = 'ElementBlogTeaser';

    private static $singular_name = 'Blog Teaser-Liste';
    private static $plural_name = 'Blog Teaser-Liste';
    private static $description = '';

    private static $db = [
        'HTML'  => 'HTMLText',
        'Limit' => 'Int',

    ];

    private static $has_one = [
        'ReadMoreLink' => Link::class,
        'Blog'         => Blog::class,
        'Category'     => BlogCategory::class
    ];

    private static $has_many = [
    ];

    private static $many_many = [];

    private static $belongs_many_many = [];

    private static $owns = [
    ];

    private static $defaults = [
        'Limit' => 3
    ];

    private static $colors = [];


    private static $field_labels = [
        'Title' => 'Titel',
        'Sort' 	=>	'Sortierung'
    ];

    public function FieldLabels($includerelations = true)
    {
        $labels = parent::fieldLabels($includerelations=true);
        $labels['Limit'] = _t(__CLASS__ . '.LimitLabel', 'Articles to show');
        $labels['BlogID'] = _t(__CLASS__ . '.FeaturedBlogLabel', 'by blog');
        $labels['CategoryID'] = _t(__CLASS__ . '.FeaturedCategoriesLabel', 'by category');


        return $labels;
    }

    public function getCMSFields()
    {
        $this->beforeUpdateCMSFields(function ($fields) {

            // Style: Description for default style (describes Layout thats used, when no special style is selected)
            $Style = $fields->dataFieldByName('Style');
            $StyleDefaultDescription = $this->owner->config()->get('styles_default_description', Config::UNINHERITED);
            if ($Style && $StyleDefaultDescription) {
                $Style->setDescription($StyleDefaultDescription);
            }

            // ReadMoreLink: use Linkfield
            $ReadMoreLink = LinkField::create('ReadMoreLinkID', 'Link');
            $fields->replaceField('ReadMoreLinkID', $ReadMoreLink);

            // Content Rows
            $fields->dataFieldByName('HTML')->setRows(8);


            if (class_exists(Blog::class)) {
                $fields->insertBefore(
                    $fields->dataFieldByName('BlogID')
                        ->setTitle(_t(__CLASS__ . '.FeaturedBlogLabel', 'by blog')),
                    'Limit'
                );
                $dataSource = function ($val) {
                    if ($val) {
                        return Blog::get()->byID($val)->Categories()->map('ID', 'Title');
                    }
                    return [];
                };
                $fields->insertAfter(
                    'BlogID',
                    DependentDropdownField::create('CategoryID', _t(__CLASS__ . '.FeaturedCategoryLabel', 'by category'), $dataSource)
                        ->setDepends($fields->dataFieldByName('BlogID'))
                        ->setHasEmptyDefault(true)
                        ->setEmptyString(_t(__CLASS__ . '.FeaturedCategoryEmptyString', ' -- Choose Category --'))

                );
            }



        });
        $fields = parent::getCMSFields();
        return $fields;
    }

    public function ReadmoreLinkClass() {
        return $this->config()->get('readmore_link_class');
    }


    /**
     * @return null|\SilverStripe\ORM\DataList|static
     */
    public function BlogPosts($offset=0)
    {
        $posts=null;
        $offset=(int) $offset;
        if ($this->BlogID) {
            $blog = Blog::get()->byID($this->BlogID);
            if ($blog && $this->CategoryID) {
                $category = BlogCategory::get()->byID($this->CategoryID);
                if($category) {
                    $posts = $category->BlogPosts()->limit($this->Limit, $offset);
                }
            } else if ($blog) {;
                $posts = $blog->getBlogPosts()->limit($this->Limit, $offset);
            }
        } else {
            if ($this->CategoryID) {
                $category = BlogCategory::get()->byID($this->CategoryID);
                if($category) {
                    $posts = $category->BlogPosts()->limit($this->Limit, $offset);
                }
            }
            $posts = BlogPost::get()->limit($this->Limit, $offset);
        }

        // hook: maybe we want to apply additional filters or sort in an extension:
        // public function updateBlogPosts(&$posts) {
        //     $posts = $posts->filter(['FeaturedImageID:GreaterThan' => 1]);
        //     $posts = $posts->sort('PublishDate ASC');
        // }
        $this->extend('updateBlogPosts', $posts);

        return $posts;
    }




}
