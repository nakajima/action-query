# action-query

jQuery and ActiveRecord, sitting in a tree...

## Usage

It's like CSS selectors, except instead of tags, we have models:

    ActionQuery['article']

    # vs.

    Article.all

CSS attributes can map to ActiveRecord too:

    ActionQuery['article[name=hello]']

    # vs.

    Article.all(:conditions => { :name => 'hello' })

## Todo

* Pseudo-selectors (map to boolean fields?)
* Better attribute parsing
* Association chaining: `ActionQuery['article:first comment']`

(c) Copyright 2009 Pat Nakajima

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
