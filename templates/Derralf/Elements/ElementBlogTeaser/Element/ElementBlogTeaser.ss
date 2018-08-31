<% if $ShowTitle %>
    <% include Derralf\\Elements\\ElementBlogTeaser\\Title %>
<% end_if %>

<% if $HTML %>
    <div class="element__content">$HTML</div>
<% end_if %>

<% if $BlogPosts %>
    <div class="blog-teaser-list">
        <div class="row isotope-container">
            <% loop $BlogPosts %>
                <div class="col-sm-4 col-md-4 isotope-item">
                    <div class="card">
                        <% if $FeaturedImage %><a href="$Link"><img class="card-img-top img-responsive forced"
                                                                    src="$FeaturedImage.ScaleWidth(360).Link"
                                                                    alt="$Title.ATT"></a><% end_if %>
                        <div class="card-block">
                            <div class="post-date h3">$PublishDate.Format('y MMMM dd')</div>
                            <h2 class="card-title"><a
                                href="$Link"><% if $MenuTitle %>$MenuTitle<% else %>$Title<% end_if %></a></h2>
                            <div class="card-text"><% if $Summary %>$Summary<% else %><p>$Excerpt</p><% end_if %></div>
                            <a href="$Link" class="btn btn-xs btn-primary btn-readmore">mehr</a>
                        </div>
                    </div>
                </div>
            <% end_loop %>
        </div>
    </div>
<% end_if %>

<% if $ReadMoreLink.LinkURL %>
    <div class="element__readmorelink"><p><a href="$ReadMoreLink.LinkURL"
                                             class="{$ReadmoreLinkClass}" {$ReadMoreLink.TargetAttr} ><% if $ReadMoreLink.Title %>$ReadMoreLink.Title<% else %>
        mehr<% end_if %></a></p></div>
<% end_if %>


