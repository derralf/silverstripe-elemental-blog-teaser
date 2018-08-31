<li class="blog-teaser-flex-list-item">
    <div class="dt">
        <div class="dtc wi">
            <a href="$Link" title="$Title.ATT">
                <% if $hasFeatureVideo %>
                    <% if $FeaturedImage %>
                        <img src="{$ThemeDir}/images/blog-latest-thumb-default-video-play.png" style="position:absolute;z-index:1;" alt="$FeaturedImage.AltText.ATT">
                        <img src="$FeaturedImage.FocusFill(64,64).Link" alt="$FeaturedImage.AltText.ATT">
                    <% else_if $VideoExternalImageUrl %>
                        <img src="{$ThemeDir}/images/blog-latest-thumb-default-video-play.png" style="position:absolute;z-index:1;" alt="$Title.ATT">
                        <span class="extimg"><img src="$VideoExternalImageUrl" alt="$Title.ATT"></span>
                    <% else %>
                        <img src="{$ThemeDir}/images/blog-latest-thumb-default-video.png" alt="$FeaturedImage.AltText.ATT">
                    <% end_if %>
                <% else_if $FeaturedImage %>
                    <img src="$FeaturedImage.FocusFill(64,64).Link" alt="$FeaturedImage.AltText.ATT">
                <% else %>
                    <img src="{$ThemeDir}/images/blog-latest-thumb-default.png" alt="$FeaturedImage.AltText.ATT">
                <% end_if %>
            </a>
        </div>
        <div class="dtc wc">
            <a href="$Link" title="$Title">
                $Title
            </a>
            <div class="date">$PublishDate.Format('y MMMM dd')</div>
        </div>
    </div>
</li>


