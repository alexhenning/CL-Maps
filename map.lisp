;;;;;; map.lisp
;;;; Title: Map Generator
;;;; Description: This is code generates and displays simple 2d maps.
;;;; Author: Alex Henning <elcron@gmail.com>
;;;; License: WTFPL

;; Include + load lispbuilder
;; TODO: eventually setup packaging + proper asdf loading
(pushnew "/home/alex/lispbuilder/lispbuilder-sdl/" asdf:*central-registry* :test #'equal)
(pushnew "/home/alex/lispbuilder/lispbuilder-sdl-image/" asdf:*central-registry* :test #'equal)
(asdf:oos 'asdf:load-op 'lispbuilder-sdl)
(asdf:oos 'asdf:load-op 'lispbuilder-sdl-image)

;; Load terrain
;; TODO: Decouple from my setup...
(defparameter *img-path* "/home/alex/Dropbox/cl/lispbuilder/maps/images/")
(defun load-terrain (type)
  (sdl-image:load-image (merge-pathnames (concatenate 'string type ".png")
					 *img-path*)))
(sdl:init-sdl :video t)
(defvar *glacier* (load-terrain "c"))
(defvar *desert* (load-terrain "d"))
(defvar *forest* (load-terrain "f"))
(defvar *grassland* (load-terrain "g"))
(defvar *hills* (load-terrain "h"))
(defvar *jungle* (load-terrain "j"))
(defvar *mountain* (load-terrain "m"))
(defvar *ocean* (load-terrain "o"))
(defvar *plains* (load-terrain "p"))
(defvar *swamp* (load-terrain "s"))
(defvar *tundra* (load-terrain "t"))
(defparameter *terrain* (list *glacier* *desert* *forest* *grassland* *hills*
			      *jungle* *mountain* *ocean* *plains* *swamp*
			      *tundra*))
(defparameter *map-generator* nil)

;; Just run this to see it at work
(defun run ()
  "Create a map with the algorithm set with *map-generator* and display it"
  (sdl:with-init ()
    (sdl:window 400 400 :title-caption "Maps")
    (setf (sdl:frame-rate) 30)

    (let ((map (funcall *map-generator*)))
      (draw-map map)
      (sdl:with-events ()
	(:quit-event () t)
	(:video-expose-event () (sdl:update-display))
	
	(:idle ()
	  (sdl:clear-display sdl:*black*)
	  (draw-map map)
	  ;(dotimes (i (length *terrain*))
	   ; (sdl:draw-surface-at (elt *terrain* i) (sdl:point
	;					    :x (+ 20 (* 30 i))
	;					    :y 190)))
	  (sdl:update-display)
	       )))))

;; Map utils
(defun get-fresh-map (&optional (width 20) (height 20))
  (make-array `(,height ,width)))
(defun draw-map (map)
  (dotimes (row (array-dimension map 0))
    (dotimes (col (array-dimension map 1))
      (sdl:draw-surface-at (aref map row col) (sdl:point :x (* 20 col)
							 :y (* 20 row))))))

;; Utils
(defun random-elt (list)
  (elt list (random (length list))))

;; An map generating algorithm that is completely random
(defun random-map (&optional (width 20) (height 20))
  (let ((map (get-fresh-map width height)))
    (dotimes (row (array-dimension map 0))
      (dotimes (col (array-dimension map 1))
	(setf (aref map row col) (random-elt *terrain*))))
    map))



;; Actual algorithm
(setf *map-generator* #'random-map)