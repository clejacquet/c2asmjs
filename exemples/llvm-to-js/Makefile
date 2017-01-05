all: ex

ex: 
	emcc llvm-examples/ex.ll --js-library libraries/p5-wrap.js -s EXPORTED_FUNCTIONS="['_my_draw','_my_setup']" -o foo.js
	google-chrome index.html

mandelbrot: 
	emcc llvm-examples/mandelbrot.ll --js-library libraries/p5-wrap.js -s EXPORTED_FUNCTIONS="['_my_draw','_my_setup']" -o foo.js
	google-chrome index.html

myex:
	emcc my-examples/my_ex.ll --js-library libraries/p5-wrap.js -s EXPORTED_FUNCTIONS="['_my_draw','_my_setup']" -o foo.js
	google-chrome index.html

mymandelbrot:
	emcc my-examples/my_mandelbrot.ll --js-library libraries/p5-wrap.js -s EXPORTED_FUNCTIONS="['_my_draw','_my_setup']" -o foo.js
	google-chrome index.html

.PHONY: clean

clean:
	rm -f foo.js *~
