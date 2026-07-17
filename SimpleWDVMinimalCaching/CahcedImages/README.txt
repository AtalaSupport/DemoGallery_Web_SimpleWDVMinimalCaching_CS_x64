# READ ME
This CachedImages folder is where the image files cashed by the handler will be stored

Each time a URL is supplied to OpenUrl (as opposed to a virtual path), The DoucmentInfoRequested
is going to featch the file from the web and store it in a temp file here and redirect to it

This means this directory will build up files over time

You will need to either implement more "intelligent" caching or else write a tool to scavenge 
unneeded files at some interval



