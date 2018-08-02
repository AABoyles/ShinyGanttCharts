# ShinyGanttCharts

![Example Gantt Chart](https://github.com/aaboyles/ShinyGanttCharts/raw/master/src/download.png "Example Gantt Chart")

A Shiny App to create Gantt Charts by [Anthony A. Boyles](http://anthony.boyles.cc)

Gantt Chart code adapted from [this post](https://stats.andrewheiss.com/misc/gantt.html) by Andrew Heiss

**[Click Here to Download a Demo File](https://github.com/aaboyles/ShinyGanttCharts/blob/master/demo.csv)**

## How do I get this thing running?

*Note*: You're probably only going to be able to use this if you're already an R user. Getting an R environment set up is complexity that's far outside the scope of this project. If you can't use R, just go to https://aaboyles.shinyapps.io/shinyganttcharts/ If you CAN use R, please do, as I'm not paying for shinyapps.io hosting and the free tier runs out really, really quickly.

You're going to need an R environment with Shiny, tidyverse, lubridate, and scales installed. If you don't have these, run this:

```r
install.packages(c('shiny', 'tidyverse', 'lubridate', 'scales', 'readxl', 'rhandsontable'))
```

In R, run the following:

```r
library(shiny)
runGitHub('ShinyGanttCharts', 'aaboyles')
```

That should launch the Shiny app.

## OK, so how do I use it?

First, you're going to need a **schedule file**. Basically, we need the data to create the Gantt chart in a well-structured format. That format is:

|Start|End|Project|Task|
| --- | - | ----- | -- |
|2015-11-15|2015-11-20|Data collection|Use IssueCrawler to expand lists|
|2015-11-21|2015-11-25|Data collection|Complete INGO databases|
|2015-11-16|2015-12-15|Data collection|Find all INGO legislation|

Some things to note:
* There are four headers, which are: `Start`, `End`, `Project`, and `Task`. They are all mandatory and case sensitive. Additional columns will be ignored.
* `Start` and `End` are dates. Furthermore, they're [ISO-8601 compliant dates](https://en.wikipedia.org/wiki/ISO_8601) (YYYY-MM-DD). This app **might** work with your date formats, but I don't guarantee it. If you're getting errors using other date formats, use your spreadsheet program to "Format Data" (or whatever) as `YYYY-MM-DD` date format.

If you just want to try it, **[Download a Demo File](https://github.com/aaboyles/ShinyGanttCharts/blob/master/demo.csv)**.

## What if I don't want to do that?

The App launches with a blank dataset by default. You can right-click on the table and click "Add Row Below" for each task that you want to plot on your chart. Each new row can be edited in-place on that table. It's a bit laborious, but fool-proof (inasmuch as it forces you to create well-formatted data).

## OK, so where's the chart?

Click on the "Gantt" Tab, next to "Table". There you go.

## Hey, could you...

Let me stop you right there. Please [file an issue](https://github.com/AABoyles/ShinyGanttCharts/issues/new) to request your fancy new feature or report that terrible bug.

# Here's a bunch of lawyer stuff CDC makes us put in our repos!

This repository was created for use by CDC programs to collaborate on public health surveillance related projects in support of the CDC Surveillance Strategy.  Github is not hosted by the CDC, but is used by CDC and its partners to share information and collaborate on software.

## Public Domain
This repository constitutes a work of the United States Government and is not
subject to domestic copyright protection under 17 USC § 105. This repository is in
the public domain within the United States, and copyright and related rights in
the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
All contributions to this repository will be released under the CC0 dedication. By
submitting a pull request you are agreeing to comply with this waiver of
copyright interest.

## License
The repository utilizes code licensed under the terms of the Apache Software
License and therefore is licensed under ASL v2 or later.

This source code in this repository is free: you can redistribute it and/or modify it under
the terms of the Apache Software License version 2, or (at your option) any
later version.

This soruce code in this repository is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the Apache Software License for more details.

You should have received a copy of the Apache Software License along with this
program. If not, see http://www.apache.org/licenses/LICENSE-2.0.html

The source code forked from other open source projects will inherit its license.


## Privacy
This repository contains only non-sensitive, publicly available data and
information. All material and community participation is covered by the
Surveillance Platform [Disclaimer](https://github.com/CDCgov/template/blob/master/DISCLAIMER.md)
and [Code of Conduct](https://github.com/CDCgov/template/blob/master/code-of-conduct.md).
For more information about CDC's privacy policy, please visit [http://www.cdc.gov/privacy.html](http://www.cdc.gov/privacy.html).

## Contributing
Anyone is encouraged to contribute to the repository by [forking](https://help.github.com/articles/fork-a-repo)
and submitting a pull request. (If you are new to GitHub, you might start with a
[basic tutorial](https://help.github.com/articles/set-up-git).) By contributing
to this project, you grant a world-wide, royalty-free, perpetual, irrevocable,
non-exclusive, transferable license to all users under the terms of the
[Apache Software License v2](http://www.apache.org/licenses/LICENSE-2.0.html) or
later.

All comments, messages, pull requests, and other submissions received through
CDC including this GitHub page are subject to the [Presidential Records Act](http://www.archives.gov/about/laws/presidential-records.html)
and may be archived. Learn more at [http://www.cdc.gov/other/privacy.html](http://www.cdc.gov/other/privacy.html).

## Records
This repository is not a source of government records, but is a copy to increase
collaboration and collaborative potential. All government records will be
published through the [CDC web site](http://www.cdc.gov).

## Notices
Please refer to [CDC's Template Repository](https://github.com/CDCgov/template)
for more information about [contributing to this repository](https://github.com/CDCgov/template/blob/master/CONTRIBUTING.md),
[public domain notices and disclaimers](https://github.com/CDCgov/template/blob/master/DISCLAIMER.md),
and [code of conduct](https://github.com/CDCgov/template/blob/master/code-of-conduct.md).
