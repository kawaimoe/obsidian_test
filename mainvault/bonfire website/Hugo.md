## Make site directory:

`>hugo new site <site name>`
`>cd <site name>`

## Hugo create site:

`>cd <site name>`
`>hugo`

(this will put the site in the "public directory" with files like index.html)

## How to start local webserver

`>cd <site name>`
`>hugo server`

(this will create a local server so you can view the page on http://localhost:1313/

## How to make a new page (e.g http://localhost:1313/about <---)

`>cd <site name>`
`>hugo new about.md (this will now be in "content" directory)`
`>nano content/about.md`
(modify page to your liking, then set draft=false to make it live in local webserver) 

## Adding images to webpage:

(add the image to the static directory)
(edit the .md file that is linked to the page)
`>nano content/about.md`
(enter this at wherever you want it to be in page):  !\[my image\](/imagename.png)

## Modify the initial main page (not using config.toml)

`>nano content/_index.md`
(now add stuff to make your website,

for example:

```markdown
---
title: "my website"
---

Content here...
```

## Time to upload stuff to webserver:

run hugo command in &lt;site name&gt; directory

copy contents of the public directory to server, either through git or manually

* * *

### Items and directories

config.toml: global config for hug

"content" directory: markdown files that tell hugo what pages you want (hugo will create html pages based on markdown content"

"public" directory: 

"static" directory: contains items like styles.css or images/documents etc

"archetypes" directory: this is the default config for the 'hugo new' command. It can control how the webpage will look based off you config.