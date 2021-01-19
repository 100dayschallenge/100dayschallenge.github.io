---
layout: page
title: Recipes
permalink: /recipes/
menu : true
order: 2
---

{% for receipt in site.recipes %}
<h2>{{ receipt.name }} - {{ receipt.complexity }}</h2>
  <div>{{ receipt.content | markdownify }}</div>
{% endfor %}





