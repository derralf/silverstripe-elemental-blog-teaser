

<div class="element__container-breakout">
    <div class="well blog-teaser-well">
        <div class="container">

            <% if $ShowTitle %>
                <% include Derralf\\Elements\\ElementBlogTeaser\\Title %>
            <% end_if %>

            <% if $HTML %>
                <div class="element__content">$HTML</div>
            <% end_if %>

            <%-- one big featured post --%>
            <% if $BlogPosts %>
                <% with $BlogPosts.First %>
                <div class="featured-post">
                    <% if $FeaturedImage %>
                        <div class="image" style="background-image:url({$FeaturedImage.Link})"><a href="$Link"></a></div>
                    <% end_if %>
                    <div class="content">
                        <div class="inner">
                            <div class="post-date">$PublishDate.Format('y MMMM dd')</div>
                            <h2 class="post-title"><a href="$Link"><% if $MenuTitle %>$MenuTitle<% else %>$Title<% end_if %></a></h2>
                            <div class="post-text"><% if $Summary %>$Summary<% else %><p>$Excerpt</p><% end_if %></div>
                            <a href="$Link" class="btn btn-xs btn-primary btn-readmore">mehr</a>
                        </div>
                    </div>
                </div>
                <% end_with %>
            <% end_if %>

            <%-- if more than 1 Post available: --%>
            <% if $BlogPosts.Limit(2) %>
                <div class="recent-posts-container">
                    <h3><%t Derralf\Elements\ElementBlogTeaser\Element\ElementBlogTeaser.RecentPosts 'Recent Posts'  %></h3>
                    <ul class="blog-teaser-flex-list">
                        <% loop $BlogPosts.Limit(999,1) %>
                            <% include Derralf\\Elements\\ElementBlogTeaser\\FlexListItem %>
                        <% end_loop %>
                    </ul>
                </div>
            <% end_if %>

            <% if $ReadMoreLink.LinkURL %>
                <div class="element__readmorelink"><p><a href="$ReadMoreLink.LinkURL" class="{$ReadmoreLinkClass}" {$ReadMoreLink.TargetAttr} ><% if $ReadMoreLink.Title %>$ReadMoreLink.Title<% else %> mehr<% end_if %></a></p></div>
            <% end_if %>

        </div>
    </div>
</div>


