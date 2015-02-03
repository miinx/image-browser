The Image Browser is a Ruby application that reads in an XML input file containing EXIF image data, & outputs a set of linked, static HTML pages which allow a user to browse the images from the XML, categorised by camera make & model.

#### Assumptions

- Works in the XML will always have a thumbnail
  * i.e. empty Work objects are not removed after parsing of the input xml.
- Works are not duplicated in the xml.
- Camera makes & models have consistent spelling.
- XML is valid.


#### How to use

Run the following commands from the app root.

To run the tests:
```
> rspec spec
```

To run the app from the command line:
```
> bin/image_gallery.rb -i <input file> -o <target output directory>
```

To see help for the command line options:
```
> bin/image_gallery.rb
```
or
```
> bin/image_gallery.rb -h
```

