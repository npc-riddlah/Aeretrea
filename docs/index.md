---
layout: default
title: Home
nav_order: 1
permalink: /
---

<p align="center">
  <img loading="lazy" width="60%" src="/Aeretrea/assets/images/logo.png"/>
  <br><br>
  <a href="https://github.com/Aeretrea/Aeretrea"><img loading="lazy" src="https://img.shields.io/badge/GitHub-453f3d?style=for-the-badge&logo=github"/></a>
  <a href="https://t.me/Aeretrea"><img loading="lazy" src="https://img.shields.io/badge/Telegram-229ed9?style=for-the-badge&logo=telegram&logoColor=ffffff"/></a>
</p>

- [Installation instructions]({% link guide/index.md %})
- [Supported devices]({% link devices/index.md %})
- [Developer guides]({% link expert/index.md %})
- [Troubleshooting]({% link faq/index.md %})

#### Thank you to the contributors of Aeretrea!
{: .pt-6 }
<ul class="list-style-none">
{% for contributor in site.github.contributors %}
  <li class="d-inline-block mr-1">
     <a href="{{ contributor.html_url }}"><img src="https://images.weserv.nl/?url={{ contributor.avatar_url }}&h=32&w=32&fit=cover&mask=circle" alt="{{ contributor.login }}"></a>
  </li>
{% endfor %}
</ul>
