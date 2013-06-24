---
title: 3D Polar ListPlots in Mathematica
layout: post
summary: Mathematica doesn't have a built in way to produce 3D plots from polar coordinates. Fortunately, the workaround is simple.
---
I recently needed to plot some polar data for a project at work, and the data happened to be 3-dimensional. In addition to the standard rotation and radius, it had a third dimension that corresponded to a strength metric. Unfortunately, *Mathematica* (my tool of choice for data manipulation and plotting) lacks native support for 3D plotting in the polar coordinate system. It does, however, have excellent support for list/matrix manipulation, so I was able to put together this one-liner to produce a 3D plot from a `N x 3` matrix:

    