# rails-search-demo
Demo application for gather different search and suggestion techniques implemented in different existing projects.

This demo using free artworks database as seed source. 
Database source: 

[GITHUB](https://github.com/MuseumofModernArt/collection)

Reason of this demo - demonstrations or realtime searching based on PostgreSQL sophsticated ranked search with partitions.

This demo using [![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.1407301.svg)](http://dx.doi.org/10.5281/zenodo.1407301) as seed source.

[StimulusReflex](https://github.com/MuseumofModernArt/collection) for real time based interactions based on Web Sockets
**No custom JavaScript was written for this demo.**
Based on [Tabular Example](https://expo.stimulusreflex.com/demos/tabular)
 
Server search based on PostgreSQL ts vector fields, which are formed by trigger actions on model update.

Just start typing in input box. **What will happen:**

- Table will be updated by realtime search of Artworks by `title` and `accession number`
- In same time dropdown with 5 top results of each related to Artworks models will appear [Artist, Classification, Department]
- On click on dropdown Item Artworks will be filtered by  [Artist, Classification, Department], or in case or Artwork selection - Selected Artwork will show.


**Example:** Type 'Photography', choose department - Artworks in Photography will be shown.

In browser Dev Tools you can check duration of reflex action from logs.

## Installation
```
rails db:setup
rails db:seed
```

seeds.rb will download, unzip and parse CSV filling the database. 
Notice that
