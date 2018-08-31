<li class="blog-teaser-flex-list-item">
    <div class="dt">
        <% if $FeaturedImage %>
        <div class="dtc wi">
            <a href="$Link" title="$Title.ATT">
                <img src="$FeaturedImage.FocusFill(64,64).Link" alt="$FeaturedImage.AltText.ATT">
            </a>
        </div>
        <% end_if %>
        <div class="dtc wc">
            <a href="$Link" title="$Title">
                $Title
            </a>
            <div class="date">$PublishDate.Format('y MMMM dd')</div>
        </div>
    </div>
</li>


