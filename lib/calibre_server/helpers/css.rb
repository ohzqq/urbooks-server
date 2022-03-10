module CalibreAPI
  module Server
    module Helpers
      module Css
        extend self

        def compile(path)
          stylesheet = <<~CSS
:root {
  --bg: #{lib.theme.web.default_bg};
  --fg: #{lib.theme.web.default_fg};

  --white: #{lib.theme.web.white};
  --black: #{lib.theme.web.black};
  --grey: #{lib.theme.web.grey};
  --yellow: #{lib.theme.web.yellow};
  --red: #{lib.theme.web.red};
  --pink: #{lib.theme.web.pink};
  --cyan: #{lib.theme.web.cyan};
  --blue: #{lib.theme.web.blue};
  --green: #{lib.theme.web.green};
  --purple: #{lib.theme.web.purple};

  --darken: brightness(90%);

  --btn-side-padding: 0.25em;
  --bar-side-padding: 0.1em;
  --bar-top-bottom-padding: 0.2em;
}

@font-face {
  font-family: "Material Icons";
  font-style: normal;
  font-weight: 400;
  src: local("Material Icons");
  src: local("MaterialIconsRound-Regular");
  src: url("/MaterialIconsRound-Regular.otf") format("opentype");
}
.material-icons {
  font-family: "Material Icons";
  font-weight: normal;
  font-style: normal;
  font-size: 1em;
  display: inline-block;
  line-height: 1;
  text-transform: none;
  letter-spacing: normal;
  word-wrap: normal;
  white-space: nowrap;
  direction: ltr;
  /* Support for all WebKit browsers. */
  -webkit-font-smoothing: antialiased;
  /* Support for Safari and Chrome. */
  text-rendering: optimizeLegibility;
  /* Support for IE. */
  font-feature-settings: "liga";
}

.feather {
  width: 1em;
  height: 1em;
  stroke: currentColor;
  stroke-width: 2;
  stroke-linecap: round;
  stroke-linejoin: round;
  fill: none;
}

.w3-container {
  padding: 0;
}

body {
  color: var(--fg);
  background-color: var(--bg);
  max-width: 1200px; 
  font-size: 1em;
}

video {
  max-width: 100%;
  max-height: 100vh;
}

img {
  max-width: 100%;
  max-height: 100vh;
}

.thumb {
  max-width: 500px;
}

nav {
  color: var(--black);
  background-color: var(--purple);
}
  nav .w3-button:hover {
    color: var(--white) !important;
    background-color: var(--purple) !important;
    filter: var(--darken);
}

.foot {
  background-color: var(--green);
  border: 1px solid var(--black);
}

.w3-sidebar {
  color: var(--black);
  background-color: var(--green);
  display: none;
  z-index: 2;
  width: 50%;
}

#sidebar-close {
	display: none;
}
#sidebar {
	display: none;
	right: 0;
}
  #sidebar .w3-button:hover {
    color: var(--white) !important;
    background-color: var(--purple) !important;
    filter: var(--darken);
}
  #sidebar .sidebar-dropdown {
    padding-left: 0.5em;
}  

.w3-modal {
  padding: 0;
}

#mediaModal {
  display: none;
}
  #mediaModal .w3-btn {
    z-index: 3;
}

.full-screen {
  width: 100vw;
  height: 100%;
  min-height: 100%;
  box-sizing: border-box;
  overflow-x: hidden;
  overflow-y: hidden;
}

.title {
  background-color: var(--green);
  color: var(--black);
}
  .title .w3-button:hover {
    background-color: var(--green);
    filter: var(--darken);
}

.item {
  border-left: 1em solid var(--grey);
}
	.item > a {text-decoration: none;}
  .item-cover {
    max-height: 10em;
		padding-right: 1em;
}
	.item-meta {
		max-height: 10em;
		overflow: hidden;
}

.cover {
  /*max-width: 500px;*/
}

.feed-button {
 /* background-color: var(--green);*/
  color: var(--green);
  filter: var(--darken);
}
.feed-link {
  /*padding: var(--btn-side-padding) 0 var(--btn-side-padding) 0;*/
	text-decoration: none;
	display: inline;
}

.post-nav {
  padding-bottom: 2em;
}

.paginate {
  color: var(--purple);
}
  .paginate:hover {
    color: var(--white) !important;
    background-color: var(--purple) !important;
    filter: var(--darken);
}

.search {
  background-color: var(--bg);
}

form.search input[type=text] {
  background-color: var(--white);
  border: 2px solid var(--bg);
}

.icon {
  padding-bottom: 0;
}

.search .icon {
  color: var(--fg);
  border: none;
  /*padding-top: 0;*/
}
.search .icon:hover {
  color: var(--bg);
  background-color: var(--green);
}

.meta .w3-bar-item {
  padding: 0;
  margin: var(--bar-top-bottom-padding) var(--bar-side-padding) var(--bar-top-bottom-padding) var(--bar-side-padding);
}
.meta .w3-bar {
  padding: var(--bar-side-padding) 0 var(--bar-side-padding) 0;
}
.meta .w3-btn {
  padding: 0 var(--btn-side-padding) 0 var(--btn-side-padding);
}
.meta-download {
  background-color: var(--green);
  color: var(--black);
  margin-right: 1em;
  filter: var(--darken);
}
.meta-tags {
  background-color: var(--green);
  color: var(--black);
}
.meta-authors {
  background-color: var(--cyan);
  color: var(--black);
}
.meta-narrators {
  background-color: var(--pink);
  color: var(--black);
}
.meta-series {
  background-color: var(--blue);
  color: var(--black);
}

.taxonomy .w3-bar-item {
  padding: 0;
  margin: var(--bar-top-bottom-padding) var(--bar-side-padding) var(--bar-top-bottom-padding) var(--bar-side-padding);
}
.taxonomy .w3-bar {
  padding: var(--bar-side-padding) 0 var(--bar-side-padding) 0;
}
.taxonomy .w3-btn {
  padding: 0 var(--btn-side-padding) 0 var(--btn-side-padding);
}
.taxonomy-label {
  padding-left: 1em;
}
.taxonomy-tags {
  border-left: 1em solid var(--green);
}
.taxonomy-authors {
  border-left: 1em solid var(--cyan);
}
.taxonomy-narrators {
  border-left: 1em solid var(--pink);
}
.taxonomy-series {
  border-left: 1em solid var(--blue);
}
        CSS

        File.write(path, stylesheet)
        end
      end
    end
  end
end

