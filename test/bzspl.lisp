#!/usr/bin/sbcl --script

(load "../src/load")
(asdf:load-system "weir")
(load "../utils/test")

(defun test-bzspl ()
(let ((pts-a (list (vec:vec -20.0d0 99.0d0)
                   (vec:vec 0.0d0 1.0d0)
                   (vec:vec 10.0d0 20.0d0)
                   (vec:vec 100.0d0 100.0d0)))
      (pts-b (list (vec:vec -20.0d0 99.0d0)
                   (vec:vec 0.0d0 1.0d0)
                   (vec:vec 10.0d0 20.0d0)
                   (vec:vec 100.0d0 100.0d0)
                   (vec:vec -3.0d0 -17.0d0)
                   (vec:vec 0.0d0 4.0d0)))
      (pts-c (list (vec:vec -32.0d0 79.0d0)
                   (vec:vec 0.3d0 3.0d0)
                   (vec:vec 10.1d0 25.0d0))))
    (do-test
      (bzspl:pos* (bzspl:make pts-c) (math:linspace 5 0d0 1d0))
      (list (vec:vec -32.0d0 79.0d0)
            (vec:vec -17.256249999999998d0 47.125d0)
            (vec:vec -5.324999999999999d0 27.5d0)
            (vec:vec 3.7937499999999993d0 20.125d0)
            (vec:vec 10.1d0 25.0d0)))

    (do-test
      (bzspl:pos* (bzspl:make pts-c :closed t) (math:linspace 5 0d0 1d0))

      (list (vec:vec -15.85d0 41.0d0)
            (vec:vec 2.046875d0 11.5625d0)
            (vec:vec 3.6125d0 29.0d0)
            (vec:vec -19.150000000000002d0 61.4375d0)
            (vec:vec -15.85d0 41.0d0)))

    (do-test
      (bzspl:pos* (bzspl:make pts-a) (math:linspace 10 0d0 1d0))
      (list (vec:vec -20.0d0 99.0d0)
            (vec:vec -11.851851851851853d0 60.75308641975309d0)
            (vec:vec -5.185185185185186d0 33.12345679012346d0)
            (vec:vec -8.881784197001252d-16 16.111111111111114d0)
            (vec:vec 3.7037037037037024d0 9.716049382716054d0)
            (vec:vec 7.160493827160495d0 13.481481481481485d0)
            (vec:vec 17.777777777777775d0 24.666666666666664d0)
            (vec:vec 36.7901234567901d0 42.814814814814795d0)
            (vec:vec 64.19753086419752d0 67.92592592592591d0)
            (vec:vec 100.0d0 100.0d0)))

    (do-test
      (bzspl:pos* (bzspl:make pts-b) (math:linspace 10 0d0 1d0))
      (list (vec:vec -20.0d0 99.0d0)
            (vec:vec -5.185185185185186d0 33.12345679012346d0)
            (vec:vec 3.7037037037037024d0 9.716049382716054d0)
            (vec:vec 12.777777777777775d0 20.22222222222222d0)
            (vec:vec 36.9753086419753d0 43.728395061728385d0)
            (vec:vec 70.23456790123457d0 72.91358024691358d0)
            (vec:vec 72.11111111111111d0 69.55555555555556d0)
            (vec:vec 37.728395061728435d0 29.481481481481524d0)
            (vec:vec 8.098765432098773d0 1.0370370370370405d0)
            (vec:vec 0.0d0 4.0d0)))

    (do-test
      (bzspl:pos* (bzspl:make pts-a :closed t) (math:linspace 10 0d0 1d0))
      (list (vec:vec -10.0d0 50.0d0)
            (vec:vec -2.098765432098766d0 18.000000000000004d0)
            (vec:vec 3.8271604938271597d0 9.111111111111114d0)
            (vec:vec 12.777777777777775d0 20.22222222222222d0)
            (vec:vec 36.9753086419753d0 43.728395061728385d0)
            (vec:vec 69.81481481481482d0 75.77777777777779d0)
            (vec:vec 68.33333333333334d0 95.33333333333331d0)
            (vec:vec 27.53086419753091d0 98.79012345679014d0)
            (vec:vec -5.061728395061721d0 83.97530864197533d0)
            (vec:vec -10.0d0 50.0d0)))

    (do-test
      (bzspl:pos* (bzspl:make pts-b :closed t) (math:linspace 10 0d0 1d0))
      (list (vec:vec -10.0d0 50.0d0)
            (vec:vec 1.1111111111111107d0 10.666666666666668d0)
            (vec:vec 12.777777777777775d0 20.22222222222222d0)
            (vec:vec 55.0d0 60.0d0)
            (vec:vec 72.11111111111111d0 69.55555555555556d0)
            (vec:vec 20.055555555555546d0 10.166666666666655d0)
            (vec:vec -1.5d0 -6.5d0)
            (vec:vec -4.611111111111104d0 23.9444444444444d0)
            (vec:vec -14.444444444444443d0 72.44444444444443d0)
            (vec:vec -10.0d0 50.0d0)))

    (rnd:set-rnd-state 1)

    (do-test
      (let ((a (list)))
        (bzspl:with-rndpos ((bzspl:make pts-b :closed t) 5 v)
          (setf a (append a (list v))))
        a)
      (list (vec:vec -10.08497035719275d0 51.90358188928061d0)
            (vec:vec 72.94161639142136d0 70.67347981875085d0)
            (vec:vec -9.972643319179285d0 49.866015920500494d0)
            (vec:vec 4.718551216740959d0 -4.763338116541952d0)
            (vec:vec 35.77978017789251d0 42.626750166588465d0)))

    (do-test (length (bzspl:adaptive-pos (bzspl:make pts-a))) 31)

    (do-test
      (bzspl:adaptive-pos (bzspl:make (list (vec:vec 0d0 0d0)
                                            (vec:vec 1d0 2d0)
                                            (vec:vec -3d0 5d0))))
      (list (vec:vec 0.0d0 0.0d0)
            (vec:vec 0.18643209278419098d0 1.0719185917278686d0)
            (vec:vec -0.09541948616495921d0 1.9685997925944037d0)
            (vec:vec -0.8581716831302144d0 3.0757985486108788d0)
            (vec:vec -1.530471900097555d0 3.7746049937079564d0)
            (vec:vec -3.0d0 5.0d0)))

    (do-test
      (bzspl:adaptive-pos (bzspl:make (list (vec:vec 0d0 0d0)
                                            (vec:vec 1d0 2d0)
                                            (vec:vec -3d0 5d0))
                                      :closed t))
      (list (vec:vec 0.5d0 1.0d0)
            (vec:vec 0.34369428112685496d0 2.1756813817990692d0)
            (vec:vec -0.3661101319802346d0 2.980843763395622d0)
            (vec:vec -1.9897280476541732d0 4.061850847855913d0)
            (vec:vec -2.087899364481774d0 3.648441004667016d0)
            (vec:vec -0.907456391822953d0 1.5952742657912453d0)
            (vec:vec -0.16395699030197697d0 0.8157890863508436d0)
            (vec:vec 0.5d0 1.0d0)))

    (do-test (bzspl:len (bzspl:make pts-a)) 225.04803388452214d0)

    (do-test (bzspl:len (bzspl:make pts-a :closed t)) 275.04416436128014d0)))


(defun main ()
  (test-title (test-bzspl))
  (test-title (test-summary)))

(main)

