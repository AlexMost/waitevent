React = require 'react'
{div, span} = React.DOM

twitter_button = ->
    return """
<a href="https://twitter.com/share" class="twitter-share-button">Tweet</a>
<script>
!function(d,s,id){
var js,
    fjs=d.getElementsByTagName(s)[0],
    p=/^http:/.test(d.location)?'http':'https';
if(!d.getElementById(id)){
js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';
fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');
</script>
    """

TwitterButton = React.createClass
    displayName: "TwitterButton"
    render: ->
        span
            style:
                display: "inline-block"
                width: "90px"
            dangerouslySetInnerHTML:
                __html: twitter_button()


facebook_button = ->
    return """
<span id="fb-root"></span>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_GB/sdk.js#xfbml= \
  1&appId=342797702557873&version=v2.0";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

<span
    class="fb-like"
    data-href="https://developers.facebook.com/docs/plugins/"
    data-layout="button_count"
    data-action="like"
    data-show-faces="true"
    data-share="true"></span>
"""


FacebookButton = React.createClass
    displayName: "FacebookButton"
    render: ->
        span
            style: {"vertical-align": "top", display: "inline-block"}
            dangerouslySetInnerHTML:
                __html: facebook_button()


google_button = ->
    return """
    <script type="text/javascript">
  (function() {
    var po = document.createElement('script');
    po.type = 'text/javascript'; po.async = true;
    po.src = 'https://apis.google.com/js/plusone.js?onload=onLoadCallback';
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(po, s);
  })();
</script>
<div
    class="g-plusone"
    data-size="medium"
    data-width="130"></div>
    """


GoogleButton = React.createClass
    displayName: "GoogleButton"
    render: ->
        span
            style:
                "vertical-align": "top"
                display: "inline-block"
                width: "120px"
            dangerouslySetInnerHTML:
                __html: google_button()


module.exports = {TwitterButton, FacebookButton, GoogleButton}