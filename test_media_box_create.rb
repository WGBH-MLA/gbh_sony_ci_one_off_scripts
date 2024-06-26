@error = nil
@client = SonyCiApi::Client.new('ci.yml')

@guids = [
  "cpb-aacip-1d9022ab674",
  "cpb-aacip-eeebdef7abc",
  "cpb-aacip-80-988gv8g6",
  "cpb-aacip-80-97xkthmn",
  "cpb-aacip-80-977srsd0",
  "cpb-aacip-80-9351czf2",
  "cpb-aacip-80-9351cw6x",
  "cpb-aacip-80-91sf89bm",
  "cpb-aacip-80-81jhbp2c",
  "cpb-aacip-80-79h4584f",
  "cpb-aacip-80-79574cj9",
  "cpb-aacip-80-77sn0pwj",
  "cpb-aacip-80-76f1w575",
  "cpb-aacip-80-75r7tj08",
  "cpb-aacip-80-73pvn5qv",
  "cpb-aacip-80-71ngfrjs",
  "cpb-aacip-80-66vx155n",
  "cpb-aacip-80-65h9wqbh",
  "cpb-aacip-80-644qs8bk",
  "cpb-aacip-80-644qs3tz",
  "cpb-aacip-80-483jb508",
  "cpb-aacip-80-386hfdtv",
  "cpb-aacip-80-246q5vh5",
  "cpb-aacip-80-07tmq0tp",
  "cpb-aacip-80-04rjf1z9",
  "cpb-aacip-a188992a787",
  "cpb-aacip-e11ee6f018a",
  "cpb-aacip-c1c2472d567",
  "cpb-aacip-85a66aae4a2",
  "cpb-aacip-c205c49d536",
  "cpb-aacip-d449704a070",
  "cpb-aacip-e9833ab0c73",
  "cpb-aacip-c8fd7478ae8",
  "cpb-aacip-ecad8c94a21",
  "cpb-aacip-1d982f9a953",
  "cpb-aacip-8402d193aa0",
  "cpb-aacip-0578e6ed0d2",
  "cpb-aacip-9af0ba0f3a9",
  "cpb-aacip-4a96f784f85",
  "cpb-aacip-8aeedec9732",
  "cpb-aacip-d7edfce7591",
  "cpb-aacip-39ce8876e4e",
  "cpb-aacip-75d6ae449d5",
  "cpb-aacip-e298da76845",
  "cpb-aacip-53a8cf500ce",
  "cpb-aacip-c4cf653f009",
  "cpb-aacip-165372efece",
  "cpb-aacip-b6b843e8e15",
  "cpb-aacip-74b3063134d",
  "cpb-aacip-4a58bb0d088",
  "cpb-aacip-a32473d94a0",
  "cpb-aacip-ca51cb421db",
  "cpb-aacip-a2700ad9077",
  "cpb-aacip-620f836cb72",
  "cpb-aacip-43bfe0ac7af",
  "cpb-aacip-daf00d3f3ab",
  "cpb-aacip-f187e81210c",
  "cpb-aacip-5655713417f",
  "cpb-aacip-b5319afc267",
  "cpb-aacip-f2753f7bf59",
  "cpb-aacip-c0766036996",
  "cpb-aacip-92fc6bc9410",
  "cpb-aacip-b2a36c805ef",
  "cpb-aacip-ee1b871a38c",
  "cpb-aacip-52965dc8381",
  "cpb-aacip-b081092858f",
  "cpb-aacip-6b2f936791d",
  "cpb-aacip-95f3b5a415d",
  "cpb-aacip-cf042a104e8",
  "cpb-aacip-acee6da937b",
  "cpb-aacip-784f206c1c8",
  "cpb-aacip-6fd08362a66",
  "cpb-aacip-729bacd94b8",
  "cpb-aacip-931c8e9d861",
  "cpb-aacip-3e7ed4642f8",
  "cpb-aacip-d830648945e",
  "cpb-aacip-64639ac70d5",
  "cpb-aacip-ff20ec1556a",
  "cpb-aacip-9eba7eb957d",
  "cpb-aacip-6b118b3595f",
  "cpb-aacip-f6e22e17db6",
  "cpb-aacip-5cac0c3ca41",
  "cpb-aacip-562c317a347",
  "cpb-aacip-cd12f1b094e",
  "cpb-aacip-b792b64974e",
  "cpb-aacip-6cb9476ffef",
  "cpb-aacip-902d13ab68a",
  "cpb-aacip-cc285e390f6",
  "cpb-aacip-74df80a4807",
  "cpb-aacip-2a9bf31b4bf",
  "cpb-aacip-a1a13f0fee1",
  "cpb-aacip-878828dba6a",
  "cpb-aacip-b4fa10c4ce8",
  "cpb-aacip-97d462a836c",
  "cpb-aacip-b2bd5741747",
  "cpb-aacip-6330e47dcb2",
  "cpb-aacip-874e27d2681",
  "cpb-aacip-4dbe290eb5d",
  "cpb-aacip-2858d890a5f",
  "cpb-aacip-144cfa427cf",
  "cpb-aacip-e68d318e769",
  "cpb-aacip-b0424d39f57",
  "cpb-aacip-e8b75853227",
  "cpb-aacip-b7cd6fa142d",
  "cpb-aacip-9a84a5748de",
  "cpb-aacip-20056c06463",
  "cpb-aacip-a877bd3581b",
  "cpb-aacip-cbc38e9e317",
  "cpb-aacip-ceff6fdcd0b",
  "cpb-aacip-772979a0d68",
  "cpb-aacip-8be883f4dc2",
  "cpb-aacip-e85cb235575",
  "cpb-aacip-5d4c9c78f3f",
  "cpb-aacip-f84908f2f76",
  "cpb-aacip-9b3cc6eaeec",
  "cpb-aacip-b2f4f383c38",
  "cpb-aacip-3e6fb8aa62b",
  "cpb-aacip-00033a67e18",
  "cpb-aacip-077e040b4eb",
  "cpb-aacip-01977f78e1c",
  "cpb-aacip-6121a64aea4",
  "cpb-aacip-80-60qrg9wk",
  "cpb-aacip-80-59189pns",
  "cpb-aacip-80-58bg7xj1",
  "cpb-aacip-80-58bg7vjq",
  "cpb-aacip-80-579s5bwr",
  "cpb-aacip-80-5370sp5b",
  "cpb-aacip-80-48sbcvwf",
  "cpb-aacip-80-44pk1dkw",
  "cpb-aacip-80-440rzh6x",
  "cpb-aacip-80-43nvxkgv",
  "cpb-aacip-80-407wmng0",
  "cpb-aacip-80-35t776nf",
  "cpb-aacip-80-35gb66d7",
  "cpb-aacip-80-33dz0w56",
  "cpb-aacip-80-31qfvbz7",
  "cpb-aacip-80-31cjtmjt",
  "cpb-aacip-80-28nckbfs",
  "cpb-aacip-80-27mpgq3f",
  "cpb-aacip-80-26xwf0bv",
  "cpb-aacip-80-25x6b73h",
  "cpb-aacip-80-21tdzmx7",
  "cpb-aacip-80-214mwsgs",
  "cpb-aacip-80-1937qh0f",
  "cpb-aacip-80-18dfnkzs",
  "cpb-aacip-80-12893k28",
  "cpb-aacip-80-418kqcv0",
  "cpb-aacip-526-ms3jw87t05",
  "cpb-aacip-526-mp4vh5dp16",
  "cpb-aacip-526-mk6542kh4p",
  "cpb-aacip-526-mg7fq9rb84",
  "cpb-aacip-526-mg7fq9rb7t",
  "cpb-aacip-526-m901z4322x",
  "cpb-aacip-526-m32n58dr32",
  "cpb-aacip-526-m03xs5km86",
  "cpb-aacip-526-m03xs5km6k",
  "cpb-aacip-526-kh0dv1dt8s",
  "cpb-aacip-526-k93125rj40",
  "cpb-aacip-526-k93125rh8z",
  "cpb-aacip-526-k35m903686",
  "cpb-aacip-526-jw86h4dx59",
  "cpb-aacip-526-js9h41ks1s",
  "cpb-aacip-526-js9h41kr90",
  "cpb-aacip-526-js9h41kr8p",
  "cpb-aacip-526-jd4pk0859k",
  "cpb-aacip-526-j96057f10h",
  "cpb-aacip-526-j38kd1rq5v",
  "cpb-aacip-526-hx15m63d25",
  "cpb-aacip-526-hx15m63d0j",
  "cpb-aacip-526-ht2g73887f",
  "cpb-aacip-526-hm52f7kz77",
  "cpb-aacip-526-hm52f7kz02",
  "cpb-aacip-526-h98z893h3v",
  "cpb-aacip-526-h41jh3f69w",
  "cpb-aacip-526-h41jh3f66z",
  "cpb-aacip-526-h12v40m23r",
  "cpb-aacip-526-gx44q7rx04",
  "cpb-aacip-526-gx44q7rw0v",
  "cpb-aacip-526-gt5fb4xr6f",
  "cpb-aacip-526-gq6qz23m0c",
  "cpb-aacip-526-gm81j98f42",
  "cpb-aacip-526-g73707xv4b",
  "cpb-aacip-526-g73707xv2q",
  "cpb-aacip-526-g44hm53p27",
  "cpb-aacip-526-fx73t9fd16",
  "cpb-aacip-526-fx73t9fc3j",
  "cpb-aacip-526-ff3kw58m68",
  "cpb-aacip-526-ff3kw58m3b",
  "cpb-aacip-526-fb4wh2ff8b",
  "cpb-aacip-526-fb4wh2ff5d",
  "cpb-aacip-526-f76639m99c",
  "cpb-aacip-526-f18sb3z06g",
  "cpb-aacip-526-dz02z13v5t",
  "cpb-aacip-526-dn3zs2md45",
  "cpb-aacip-526-db7vm43z7t",
  "cpb-aacip-526-d795718t1s",
  "cpb-aacip-526-cr5n87415n",
  "cpb-aacip-526-cn6xw48v8n",
  "cpb-aacip-526-cc0tq5sf91",
  "cpb-aacip-526-c53dz0446f",
  "cpb-aacip-526-c24qj78z7v",
  "cpb-aacip-526-bv79s1mp49",
  "cpb-aacip-526-br8mc8sj10",
  "cpb-aacip-526-br8mc8sh96",
  "cpb-aacip-526-br8mc8sh5z",
  "cpb-aacip-526-bn9x05zc5p",
  "cpb-aacip-526-bk16m34641",
  "cpb-aacip-526-bg2h70926c",
  "cpb-aacip-526-bc3st7fw7n",
  "cpb-aacip-526-b853f4mr37",
  "cpb-aacip-526-b56d21sm3z",
  "cpb-aacip-526-959c53g341",
  "cpb-aacip-526-7940r9n633",
  "cpb-aacip-526-4746q1th6g",
  "cpb-aacip-526-183416tz4m",
  "cpb-aacip-526-9c6rx94c91",
  "cpb-aacip-526-959c53g36n",
  "cpb-aacip-526-959c53g33q",
  "cpb-aacip-526-930ns0mx9p",
  "cpb-aacip-526-901zc7ss80",
  "cpb-aacip-526-8w3804zm8h",
  "cpb-aacip-526-8k74t6g62r",
  "cpb-aacip-526-862b854k0b",
  "cpb-aacip-526-833mw29f2j",
  "cpb-aacip-526-7p8tb0zt6q",
  "cpb-aacip-526-7p8tb0zt43",
  "cpb-aacip-526-7h1dj59h60",
  "cpb-aacip-526-736m03zx4m",
  "cpb-aacip-526-736m03zx1p",
  "cpb-aacip-526-736m03zw9w",
  "cpb-aacip-526-736m03zw8k",
  "cpb-aacip-526-707wm14r5f",
  "cpb-aacip-526-6t0gt5gg06",
  "cpb-aacip-526-6t0gt5gf9q",
  "cpb-aacip-526-6t0gt5gf8d",
  "cpb-aacip-526-6d5p844v20",
  "cpb-aacip-526-5x25b0034q",
  "cpb-aacip-526-5x25b0033d",
  "cpb-aacip-526-5t3fx74x97",
  "cpb-aacip-526-5q4rj49s2s",
  "cpb-aacip-526-5q4rj49r9p",
  "cpb-aacip-526-5d8nc5t99f",
  "cpb-aacip-526-599z030615",
  "cpb-aacip-526-599z03056f",
  "cpb-aacip-526-542j679w29",
  "cpb-aacip-526-4x54f1nj99",
  "cpb-aacip-526-4j09w09z2g",
  "cpb-aacip-526-4f1mg7gt1s",
  "cpb-aacip-526-4b2x34np2t",
  "cpb-aacip-526-445h990b4d",
  "cpb-aacip-526-416sx65659",
  "cpb-aacip-526-3x83j3b225",
  "cpb-aacip-526-3r0pr7nr92",
  "cpb-aacip-526-3r0pr7nr7f",
  "cpb-aacip-526-3n20c4tk9m",
  "cpb-aacip-526-3n20c4tk70",
  "cpb-aacip-526-3n20c4tk5c",
  "cpb-aacip-526-3n20c4tk3r",
  "cpb-aacip-526-3b5w66b429",
  "cpb-aacip-526-319s17tp62",
  "cpb-aacip-526-2v2c825c4s",
  "cpb-aacip-526-2n4zg6h251",
  "cpb-aacip-526-222r49h55j",
  "cpb-aacip-526-1v5bc3tv5d",
  "cpb-aacip-526-154dn40s5f",
  "cpb-aacip-526-125q815n7s",
  "cpb-aacip-526-0z70v8bh2s",
  "cpb-aacip-526-0p0wp9v25d",
  "cpb-aacip-526-0k26970w1p",
  "cpb-aacip-526-028pc2v51r",
  "cpb-aacip-526-zw18k7686v",
  "cpb-aacip-526-zc7rn31j2n",
  "cpb-aacip-526-xg9f47j55j",
  "cpb-aacip-526-x639z91p94",
  "cpb-aacip-526-ws8hd7q39k",
  "cpb-aacip-526-ws8hd7q37z",
  "cpb-aacip-526-wp9t14vz08",
  "cpb-aacip-526-wp9t14vx8g",
  "cpb-aacip-526-wm13n21t34",
  "cpb-aacip-526-wd3pv6cg9n",
  "cpb-aacip-526-w950g3jb4x",
  "cpb-aacip-526-w08w951v8h",
  "cpb-aacip-526-vm42r3q912",
  "cpb-aacip-526-vm42r3q83d",
  "cpb-aacip-526-vh5cc0w51s",
  "cpb-aacip-526-vd6nz81z67",
  "cpb-aacip-526-v97zk56t78",
  "cpb-aacip-526-v40js9jj22",
  "cpb-aacip-526-v11vd6qc5f",
  "cpb-aacip-526-tq5r786x0k",
  "cpb-aacip-526-tm71v5cr8g",
  "cpb-aacip-526-tm71v5cr75",
  "cpb-aacip-526-th8bg2jm7w",
  "cpb-aacip-526-th8bg2jk8x",
  "cpb-aacip-526-t727942450",
  "cpb-aacip-526-sx6445jp73",
  "cpb-aacip-526-sj19k47413",
  "cpb-aacip-526-sj19k4737p",
  "cpb-aacip-526-sj19k4733f",
  "cpb-aacip-526-sf2m61cz3x",
  "cpb-aacip-526-s46h12wh2c",
  "cpb-aacip-526-rx9377757v",
  "cpb-aacip-526-rf5k932d8z",
  "cpb-aacip-526-rb6vx0786x",
  "cpb-aacip-526-r785h7d45b",
  "cpb-aacip-526-r20rr1qt0m",
  "cpb-aacip-526-qr4nk37c53",
  "cpb-aacip-526-qj77s7k24t",
  "cpb-aacip-526-qf8jd4qx1c",
  "cpb-aacip-526-qf8jd4qw5b",
  "cpb-aacip-526-qb9v11wr3f",
  "cpb-aacip-526-q23qv3d995",
  "cpb-aacip-526-pz51g0k533",
  "cpb-aacip-526-pz51g0k49p",
  "cpb-aacip-526-pz51g0k46r",
  "cpb-aacip-526-pn8x922q0s",
  "cpb-aacip-526-pn8x922p6c",
  "cpb-aacip-526-pk06w97j1f",
  "cpb-aacip-526-pg1hh6dc82",
  "cpb-aacip-526-p26pz52s72",
  "cpb-aacip-526-nz80k27m68",
  "cpb-aacip-526-nz80k27m5z",
  "cpb-aacip-526-ns0ks6kb6h",
  "cpb-aacip-526-nk3610x173",
  "cpb-aacip-526-nk3610x15g",
  "cpb-aacip-526-ng4gm82w0c",
  "cpb-aacip-526-n872v2dk4r",
  "cpb-aacip-526-n58cf9kf04",
  "cpb-aacip-526-n58cf9kd9n",
  "cpb-aacip-526-n00zp3x42t",
  "cpb-aacip-526-n00zp3x41h",
  "cpb-aacip-2fb40f6f2c6",
  "cpb-aacip-bf44d5ae611",
  "cpb-aacip-4e0baa8a1fd",
  "cpb-aacip-4feffdf531b",
  "cpb-aacip-e0b234aed08",
  "cpb-aacip-44c05176f52",
  "cpb-aacip-3359cd63836",
  "cpb-aacip-9be493984dc",
  "cpb-aacip-3ba3f72bbe2",
  "cpb-aacip-80-2908mc44",
  "cpb-aacip-526-mk6542kg8n",
  "cpb-aacip-526-m901z43176",
  "cpb-aacip-526-m03xs5km4z",
  "cpb-aacip-526-kw57d2rf91",
  "cpb-aacip-526-k06ww7834q",
  "cpb-aacip-526-k06ww7830g",
  "cpb-aacip-526-jq0sq8rm9h",
  "cpb-aacip-526-jq0sq8rm6k",
  "cpb-aacip-526-jq0sq8rm3n",
  "cpb-aacip-526-jh3cz3398j",
  "cpb-aacip-526-j96057f13f",
  "cpb-aacip-526-j678s4kw0v",
  "cpb-aacip-526-ht2g73882w",
  "cpb-aacip-526-hh6c24rt2d",
  "cpb-aacip-526-hd7np1xn31",
  "cpb-aacip-526-h98z893h45",
  "cpb-aacip-526-h707w68c0n",
  "cpb-aacip-526-h12v40m214",
  "cpb-aacip-526-fq9q23s22d",
  "cpb-aacip-526-fn10p0xx5t",
  "cpb-aacip-526-f47gq6s49p",
  "cpb-aacip-526-dv1cj88p7s",
  "cpb-aacip-526-dr2p55fj4k",
  "cpb-aacip-526-dj58c9s767",
  "cpb-aacip-526-df6k06z35n",
  "cpb-aacip-526-df6k06z303",
  "cpb-aacip-526-d21rf5mg7b",
  "cpb-aacip-526-c53dz0441w",
  "cpb-aacip-526-bv79s1mp02",
  "cpb-aacip-526-bk16m3465b",
  "cpb-aacip-526-b27pn8zf91",
  "cpb-aacip-526-5717m0514j",
  "cpb-aacip-526-183416tz39",
  "cpb-aacip-526-9k45q4sp8k",
  "cpb-aacip-526-9c6rx94d0h",
  "cpb-aacip-526-8w3804zm76",
  "cpb-aacip-526-833mw29f0x",
  "cpb-aacip-526-7s7hq3sz5p",
  "cpb-aacip-526-7p8tb0zt71",
  "cpb-aacip-526-7h1dj59j0d",
  "cpb-aacip-526-736m03zw5n",
  "cpb-aacip-526-6m3319t45n",
  "cpb-aacip-526-696zw19p7v",
  "cpb-aacip-526-5x25b0030g",
  "cpb-aacip-526-5x25b0027c",
  "cpb-aacip-526-542j679v4n",
  "cpb-aacip-526-4x54f1nk3q",
  "cpb-aacip-526-4q7qn6080x",
  "cpb-aacip-526-445h990b8n",
  "cpb-aacip-526-3t9d50gx2n",
  "cpb-aacip-526-3t9d50gw59",
  "cpb-aacip-526-2v2c825c7q",
  "cpb-aacip-526-2v2c825c3g",
  "cpb-aacip-526-2r3nv9b71b",
  "cpb-aacip-526-2j6833nx6x",
  "cpb-aacip-526-222r49h59s",
  "cpb-aacip-526-222r49h575",
  "cpb-aacip-526-1n7xk85k4h",
  "cpb-aacip-526-1g0ht2h77b",
  "cpb-aacip-526-0z70v8bh5q",
  "cpb-aacip-526-0k26970w7j",
  "cpb-aacip-526-0k26970w4m",
  "cpb-aacip-526-057cr5p94z",
  "cpb-aacip-526-zk55d8pt7p",
  "cpb-aacip-526-zc7rn31h87",
  "cpb-aacip-526-z892806d2g",
  "cpb-aacip-526-z892806c82",
  "cpb-aacip-526-z31ng4j27q",
  "cpb-aacip-526-z02z31px6w",
  "cpb-aacip-526-xp6tx36g14",
  "cpb-aacip-526-x05x63cd3q",
  "cpb-aacip-526-x05x63cc7p",
  "cpb-aacip-526-ww76t0j84p",
  "cpb-aacip-526-wm13n21t06",
  "cpb-aacip-526-wm13n21s6s",
  "cpb-aacip-526-wd3pv6ch04",
  "cpb-aacip-526-w66930q63b",
  "cpb-aacip-526-w66930q579",
  "cpb-aacip-526-w37kp7w19d",
  "cpb-aacip-526-w08w951w09",
  "cpb-aacip-526-vq2s46jf02",
  "cpb-aacip-526-vd6nz8202h",
  "cpb-aacip-526-v97zk56t8k",
  "cpb-aacip-526-tb0xp6w97v",
  "cpb-aacip-526-tb0xp6w90p",
  "cpb-aacip-526-sx6445jp5g",
  "cpb-aacip-526-st7dr2qj99",
  "cpb-aacip-526-sn00z72788",
  "cpb-aacip-526-sj19k4736c",
  "cpb-aacip-526-s756d5qn48",
  "cpb-aacip-526-s756d5qm9j",
  "cpb-aacip-526-rx9377753m",
  "cpb-aacip-526-rr1pg1jv7p",
  "cpb-aacip-526-r20rr1qt3j",
  "cpb-aacip-526-qv3bz62h0t",
  "cpb-aacip-526-qr4nk37b8r",
  "cpb-aacip-526-qn5z60d66v",
  "cpb-aacip-526-qj77s7k18s",
  "cpb-aacip-526-pv6b27r04r",
  "cpb-aacip-526-pv6b27qz9s",
  "cpb-aacip-526-pr7mp4wv2g",
  "cpb-aacip-526-pg1hh6dd2g",
  "cpb-aacip-526-p55db7wz1p",
  "cpb-aacip-526-nk3610x084",
  "cpb-aacip-43db7e913be",
  "cpb-aacip-2e99a6b0aaa",
  "cpb-aacip-bd1e2548c35",
  "cpb-aacip-1d7ffee7f3c",
  "cpb-aacip-9393e789c2b",
  "cpb-aacip-68ca259aeaa",
  "cpb-aacip-a225f816420",
  "cpb-aacip-da76fcd2744",
  "cpb-aacip-89a2e3611af",
  "cpb-aacip-80-93ttfstk",
  "cpb-aacip-80-870vv0jc",
  "cpb-aacip-80-82x3g58q",
  "cpb-aacip-80-752frnx3",
  "cpb-aacip-80-848pkv4f",
  "cpb-aacip-9adeffc683e",
  "cpb-aacip-46eb74c07da",
  "cpb-aacip-be66968e3c9",
  "cpb-aacip-06db69fd27d",
  "cpb-aacip-d00041bf054",
  "cpb-aacip-39d0996fc91",
  "cpb-aacip-6b59dc7b9c3",
  "cpb-aacip-80-17qnksf3",
  "cpb-aacip-526-ks6j09x89c",
  "cpb-aacip-526-jq0sq8rn2m",
  "cpb-aacip-526-j38kd1rq2x",
  "cpb-aacip-526-hh6c24rt41",
  "cpb-aacip-526-h41jh3f720",
  "cpb-aacip-526-fq9q23s23q",
  "cpb-aacip-526-fn10p0xx36",
  "cpb-aacip-526-dz02z13w0j",
  "cpb-aacip-526-d50ft8fm7m",
  "cpb-aacip-526-cz3222sb3w",
  "cpb-aacip-526-bk16m3463q",
  "cpb-aacip-526-959c53g37z",
  "cpb-aacip-526-8p5v69999z",
  "cpb-aacip-526-8c9r20sw1c",
  "cpb-aacip-526-7d2q52gc6q",
  "cpb-aacip-526-6m3319t51p",
  "cpb-aacip-526-639k35nd04",
  "cpb-aacip-526-5h7br8ng5r",
  "cpb-aacip-526-5d8nc5tb6s",
  "cpb-aacip-526-4t6f18td60",
  "cpb-aacip-526-4m91835459",
  "cpb-aacip-526-2z12n50j4b",
  "cpb-aacip-526-222r49h62w",
  "cpb-aacip-526-1v5bc3tw04",
  "cpb-aacip-526-1r6n010q7z",
  "cpb-aacip-526-057cr5p93n",
  "cpb-aacip-526-xk84j0c920",
  "cpb-aacip-526-xg9f47j575",
  "cpb-aacip-526-xg9f47j519",
  "cpb-aacip-526-x05x63cd88",
  "cpb-aacip-526-w08w951w1m",
  "cpb-aacip-526-vx05x26q6k",
  "cpb-aacip-526-t72794256k",
  "cpb-aacip-526-st7dr2qj6c",
  "cpb-aacip-526-sj19k4731t",
  "cpb-aacip-526-s756d5qn6w",
  "cpb-aacip-526-rn3028qr24",
  "cpb-aacip-526-rn3028qq7d",
  "cpb-aacip-526-qv3bz62j2q",
  "cpb-aacip-526-qn5z60d69s",
  "cpb-aacip-526-q814m92m0b",
  "cpb-aacip-526-pz51g0k561",
  "cpb-aacip-526-pg1hh6dd43",
  "cpb-aacip-526-pc2t43k74j",
  "cpb-aacip-80-612nh60k",
  "cpb-aacip-5aa13df42bc",
  "cpb-aacip-cc70a026a6d",
  "cpb-aacip-64d7f59687c",
  "cpb-aacip-0dcf6227db1",
  "cpb-aacip-3f27505ea9f",
  "cpb-aacip-5d8f2fb66bb",
  "cpb-aacip-526-930ns0mx8c",
  "cpb-aacip-526-696zw19p57",
  "cpb-aacip-526-r785h7d43q",
  "cpb-aacip-526-qn5z60d71k",
  "cpb-aacip-526-pr7mp4wv43",
  "cpb-aacip-526-nk3610x12j"
]


@found_records = {}
@errors = {}

@guids.each do |guid|
  begin
    search_str = guid[-20..-1]
    sony_ci_records = @client.workspace_search(search_str)
    @found_records[guid] = sony_ci_records.detect do |sony_ci_record|
      sony_ci_record['name'] =~ /^#{guid}/
    end
  rescue => e
    @errors[guid] = e
  end
end


# @params = {
#   "name": "Test MediaBox Name",
#   "assetIds": @sony_ci_ids,
#   "type": "Secure",
#   "allowSourceDownload": false,
#   "allowPreviewDownload": true,
#   "allowElementDownload": true,
#   "recipients": [
#     "casey_davis-kaufman@wgbh.org"
#   ],
#   "message": "example message",
#   "password": "pr!v@te",
#   "expirationDays": 30,
#   "sendNotifications": true,
#   "notifyOnOpen": true,
#   "notifyOnChange": true,
#   "filters": {
#     "elements": {
#       "types": [
#         "Video"
#       ]
#     }
#   }
# }

# begin
#   @client.post '/mediaboxes', params: @params
# rescue => e
#   @error = e
# end
