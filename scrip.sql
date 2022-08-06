PGDMP     
        
            z            FEM-EDIT    14.4    14.4 Y    y           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            z           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            {           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            |           1262    17883    FEM-EDIT    DATABASE     n   CREATE DATABASE "FEM-EDIT" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE "FEM-EDIT";
                postgres    false            �            1255    17884    ufn_removemark(text)    FUNCTION     *  CREATE FUNCTION public.ufn_removemark(x text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
   codau text; kdau text; r text;
BEGIN
   codau = 'áàảãạâấầẩẫậăắằẳẵặđéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵÁÀẢÃẠÂẤẦẨẪẬĂẮẰẲẴẶĐÉÈẺẼẸÊẾỀỂỄỆÍÌỈĨỊÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢÚÙỦŨỤƯỨỪỬỮỰÝỲỶỸỴ';
   kdau  = 'aaaaaaaaaaaaaaaaadeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyAAAAAAAAAAAAAAAAADEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYY';
   r = x;
   FOR i IN 0..length(codau)
   LOOP
        r = replace(r, substr(codau,i,1), substr(kdau,i,1));
   END LOOP;
   RETURN LOWER(r);
END;
$$;
 -   DROP FUNCTION public.ufn_removemark(x text);
       public          postgres    false            �            1259    17885    tblblog    TABLE     $  CREATE TABLE public.tblblog (
    blogid character varying(20) NOT NULL,
    orgid character varying(20),
    status boolean,
    title character varying NOT NULL,
    createdate date,
    content text,
    imgurl character varying,
    numberofview integer,
    summary character varying
);
    DROP TABLE public.tblblog;
       public         heap    postgres    false            �            1259    17890    tblcommentsections    TABLE     �   CREATE TABLE public.tblcommentsections (
    commentid integer NOT NULL,
    replyid integer,
    status boolean,
    "time" timestamp without time zone NOT NULL,
    content text,
    userid character varying(50),
    eventid character varying(20)
);
 &   DROP TABLE public.tblcommentsections;
       public         heap    postgres    false            �            1259    17895     tblcommentsections_commentid_seq    SEQUENCE     �   ALTER TABLE public.tblcommentsections ALTER COLUMN commentid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tblcommentsections_commentid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    210            �            1259    17896    tbleventpost    TABLE       CREATE TABLE public.tbleventpost (
    eventid character varying(20) NOT NULL,
    orgid character varying(20),
    status boolean,
    statustypeid character varying(20),
    slotid integer,
    createdate date,
    takeplacedate date,
    content text,
    title text,
    location integer,
    imgurl character varying,
    eventtypeid integer,
    numberofview integer,
    speaker character varying(100),
    approvaldes character varying,
    summary character varying NOT NULL,
    participationlimit integer
);
     DROP TABLE public.tbleventpost;
       public         heap    postgres    false            �            1259    17901    tbleventtype    TABLE     �   CREATE TABLE public.tbleventtype (
    eventtypeid integer NOT NULL,
    eventtypename character varying(50) NOT NULL,
    status boolean
);
     DROP TABLE public.tbleventtype;
       public         heap    postgres    false            �            1259    17904    tbleventtype_eventtypeid_seq    SEQUENCE     �   ALTER TABLE public.tbleventtype ALTER COLUMN eventtypeid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tbleventtype_eventtypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    213            �            1259    17905    tbllocation    TABLE     �   CREATE TABLE public.tbllocation (
    locationid integer NOT NULL,
    locationname character varying(200) NOT NULL,
    status boolean
);
    DROP TABLE public.tbllocation;
       public         heap    postgres    false            �            1259    17908    tbllocation_locationid_seq    SEQUENCE     �   ALTER TABLE public.tbllocation ALTER COLUMN locationid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tbllocation_locationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            �            1259    17909    tblmanagers    TABLE     s   CREATE TABLE public.tblmanagers (
    managerid character varying(50) NOT NULL,
    orgid character varying(20)
);
    DROP TABLE public.tblmanagers;
       public         heap    postgres    false            �            1259    17912    tblorg_follower    TABLE     �   CREATE TABLE public.tblorg_follower (
    userid character varying(50),
    orgid character varying(20),
    status boolean,
    orgfollowerid integer NOT NULL
);
 #   DROP TABLE public.tblorg_follower;
       public         heap    postgres    false            �            1259    17915 !   tblorg_follower_orgfollowerid_seq    SEQUENCE     �   ALTER TABLE public.tblorg_follower ALTER COLUMN orgfollowerid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tblorg_follower_orgfollowerid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    218            �            1259    17916 
   tblorgpage    TABLE        CREATE TABLE public.tblorgpage (
    orgid character varying(20) NOT NULL,
    status boolean,
    orgname character varying(50) NOT NULL,
    createdate date,
    description text,
    imgurl character varying,
    email character varying(100),
    statustypeid character varying(20)
);
    DROP TABLE public.tblorgpage;
       public         heap    postgres    false            �            1259    17921    tblparticipants    TABLE     �   CREATE TABLE public.tblparticipants (
    userid character varying(50) NOT NULL,
    eventid character varying(20) NOT NULL,
    status boolean,
    qrcode character varying(200),
    participantcheck boolean
);
 #   DROP TABLE public.tblparticipants;
       public         heap    postgres    false            �            1259    17924    tblroles    TABLE     y   CREATE TABLE public.tblroles (
    roleid character varying(10) NOT NULL,
    rolename character varying(15) NOT NULL
);
    DROP TABLE public.tblroles;
       public         heap    postgres    false            �            1259    17927    tblslot    TABLE     j   CREATE TABLE public.tblslot (
    slotid integer NOT NULL,
    slottime character varying(50) NOT NULL
);
    DROP TABLE public.tblslot;
       public         heap    postgres    false            �            1259    17930    tblslot_slotid_seq    SEQUENCE     �   ALTER TABLE public.tblslot ALTER COLUMN slotid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tblslot_slotid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    223            �            1259    17931    tblstatustype    TABLE     �   CREATE TABLE public.tblstatustype (
    statustypeid character varying(20) NOT NULL,
    statustypename character varying(50)
);
 !   DROP TABLE public.tblstatustype;
       public         heap    postgres    false            �            1259    17934    tbluser_feedback    TABLE     �   CREATE TABLE public.tbluser_feedback (
    userfeedback integer NOT NULL,
    userid character varying(50),
    eventid character varying(20),
    content text
);
 $   DROP TABLE public.tbluser_feedback;
       public         heap    postgres    false            �            1259    17939 !   tbluser_feedback_userfeedback_seq    SEQUENCE     �   ALTER TABLE public.tbluser_feedback ALTER COLUMN userfeedback ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tbluser_feedback_userfeedback_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    226            �            1259    17940    tblusernotification    TABLE     �   CREATE TABLE public.tblusernotification (
    usernoti integer NOT NULL,
    userid character varying(50),
    eventid character varying(20),
    notidate date NOT NULL,
    content character varying(200) NOT NULL
);
 '   DROP TABLE public.tblusernotification;
       public         heap    postgres    false            �            1259    17943     tblusernotification_usernoti_seq    SEQUENCE     �   ALTER TABLE public.tblusernotification ALTER COLUMN usernoti ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tblusernotification_usernoti_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    228            �            1259    17944    tblusers    TABLE     �  CREATE TABLE public.tblusers (
    userid character varying(50) NOT NULL,
    fullname character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    email character varying(50),
    status boolean NOT NULL,
    typeid character varying(10),
    roleid character varying(10),
    gender character varying(10),
    phone character varying(10),
    avatarurl character varying
);
    DROP TABLE public.tblusers;
       public         heap    postgres    false            �            1259    17949    tblusertypes    TABLE     }   CREATE TABLE public.tblusertypes (
    typeid character varying(10) NOT NULL,
    typename character varying(50) NOT NULL
);
     DROP TABLE public.tblusertypes;
       public         heap    postgres    false            `          0    17885    tblblog 
   TABLE DATA           s   COPY public.tblblog (blogid, orgid, status, title, createdate, content, imgurl, numberofview, summary) FROM stdin;
    public          postgres    false    209   rx       a          0    17890    tblcommentsections 
   TABLE DATA           j   COPY public.tblcommentsections (commentid, replyid, status, "time", content, userid, eventid) FROM stdin;
    public          postgres    false    210   �       c          0    17896    tbleventpost 
   TABLE DATA           �   COPY public.tbleventpost (eventid, orgid, status, statustypeid, slotid, createdate, takeplacedate, content, title, location, imgurl, eventtypeid, numberofview, speaker, approvaldes, summary, participationlimit) FROM stdin;
    public          postgres    false    212    �       d          0    17901    tbleventtype 
   TABLE DATA           J   COPY public.tbleventtype (eventtypeid, eventtypename, status) FROM stdin;
    public          postgres    false    213   Ѱ       f          0    17905    tbllocation 
   TABLE DATA           G   COPY public.tbllocation (locationid, locationname, status) FROM stdin;
    public          postgres    false    215   "�       h          0    17909    tblmanagers 
   TABLE DATA           7   COPY public.tblmanagers (managerid, orgid) FROM stdin;
    public          postgres    false    217   ��       i          0    17912    tblorg_follower 
   TABLE DATA           O   COPY public.tblorg_follower (userid, orgid, status, orgfollowerid) FROM stdin;
    public          postgres    false    218   "�       k          0    17916 
   tblorgpage 
   TABLE DATA           r   COPY public.tblorgpage (orgid, status, orgname, createdate, description, imgurl, email, statustypeid) FROM stdin;
    public          postgres    false    220   ��       l          0    17921    tblparticipants 
   TABLE DATA           \   COPY public.tblparticipants (userid, eventid, status, qrcode, participantcheck) FROM stdin;
    public          postgres    false    221   �       m          0    17924    tblroles 
   TABLE DATA           4   COPY public.tblroles (roleid, rolename) FROM stdin;
    public          postgres    false    222   j�       n          0    17927    tblslot 
   TABLE DATA           3   COPY public.tblslot (slotid, slottime) FROM stdin;
    public          postgres    false    223   ��       p          0    17931    tblstatustype 
   TABLE DATA           E   COPY public.tblstatustype (statustypeid, statustypename) FROM stdin;
    public          postgres    false    225   ��       q          0    17934    tbluser_feedback 
   TABLE DATA           R   COPY public.tbluser_feedback (userfeedback, userid, eventid, content) FROM stdin;
    public          postgres    false    226   :�       s          0    17940    tblusernotification 
   TABLE DATA           [   COPY public.tblusernotification (usernoti, userid, eventid, notidate, content) FROM stdin;
    public          postgres    false    228   v�       u          0    17944    tblusers 
   TABLE DATA           w   COPY public.tblusers (userid, fullname, password, email, status, typeid, roleid, gender, phone, avatarurl) FROM stdin;
    public          postgres    false    230   q�       v          0    17949    tblusertypes 
   TABLE DATA           8   COPY public.tblusertypes (typeid, typename) FROM stdin;
    public          postgres    false    231   &�       }           0    0     tblcommentsections_commentid_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.tblcommentsections_commentid_seq', 1, false);
          public          postgres    false    211            ~           0    0    tbleventtype_eventtypeid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.tbleventtype_eventtypeid_seq', 4, true);
          public          postgres    false    214                       0    0    tbllocation_locationid_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.tbllocation_locationid_seq', 4, true);
          public          postgres    false    216            �           0    0 !   tblorg_follower_orgfollowerid_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.tblorg_follower_orgfollowerid_seq', 8, true);
          public          postgres    false    219            �           0    0    tblslot_slotid_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.tblslot_slotid_seq', 4, true);
          public          postgres    false    224            �           0    0 !   tbluser_feedback_userfeedback_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.tbluser_feedback_userfeedback_seq', 2, true);
          public          postgres    false    227            �           0    0     tblusernotification_usernoti_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.tblusernotification_usernoti_seq', 50, true);
          public          postgres    false    229            �           2606    17957    tblblog tblblog_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.tblblog
    ADD CONSTRAINT tblblog_pkey PRIMARY KEY (blogid);
 >   ALTER TABLE ONLY public.tblblog DROP CONSTRAINT tblblog_pkey;
       public            postgres    false    209            �           2606    17959 *   tblcommentsections tblcommentsections_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.tblcommentsections
    ADD CONSTRAINT tblcommentsections_pkey PRIMARY KEY (commentid);
 T   ALTER TABLE ONLY public.tblcommentsections DROP CONSTRAINT tblcommentsections_pkey;
       public            postgres    false    210            �           2606    17961    tbleventpost tbleventpost_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.tbleventpost
    ADD CONSTRAINT tbleventpost_pkey PRIMARY KEY (eventid);
 H   ALTER TABLE ONLY public.tbleventpost DROP CONSTRAINT tbleventpost_pkey;
       public            postgres    false    212            �           2606    17963    tbleventtype tbleventtype_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.tbleventtype
    ADD CONSTRAINT tbleventtype_pkey PRIMARY KEY (eventtypeid);
 H   ALTER TABLE ONLY public.tbleventtype DROP CONSTRAINT tbleventtype_pkey;
       public            postgres    false    213            �           2606    17965    tbllocation tbllocation_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.tbllocation
    ADD CONSTRAINT tbllocation_pkey PRIMARY KEY (locationid);
 F   ALTER TABLE ONLY public.tbllocation DROP CONSTRAINT tbllocation_pkey;
       public            postgres    false    215            �           2606    17967    tblmanagers tblmanagers_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.tblmanagers
    ADD CONSTRAINT tblmanagers_pkey PRIMARY KEY (managerid);
 F   ALTER TABLE ONLY public.tblmanagers DROP CONSTRAINT tblmanagers_pkey;
       public            postgres    false    217            �           2606    17969 $   tblorg_follower tblorg_follower_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.tblorg_follower
    ADD CONSTRAINT tblorg_follower_pkey PRIMARY KEY (orgfollowerid);
 N   ALTER TABLE ONLY public.tblorg_follower DROP CONSTRAINT tblorg_follower_pkey;
       public            postgres    false    218            �           2606    17971    tblorgpage tblorgpage_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.tblorgpage
    ADD CONSTRAINT tblorgpage_pkey PRIMARY KEY (orgid);
 D   ALTER TABLE ONLY public.tblorgpage DROP CONSTRAINT tblorgpage_pkey;
       public            postgres    false    220            �           2606    17973 $   tblparticipants tblparticipants_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.tblparticipants
    ADD CONSTRAINT tblparticipants_pkey PRIMARY KEY (userid, eventid);
 N   ALTER TABLE ONLY public.tblparticipants DROP CONSTRAINT tblparticipants_pkey;
       public            postgres    false    221    221            �           2606    17975    tblroles tblroles_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.tblroles
    ADD CONSTRAINT tblroles_pkey PRIMARY KEY (roleid);
 @   ALTER TABLE ONLY public.tblroles DROP CONSTRAINT tblroles_pkey;
       public            postgres    false    222            �           2606    17977    tblslot tblslot_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.tblslot
    ADD CONSTRAINT tblslot_pkey PRIMARY KEY (slotid);
 >   ALTER TABLE ONLY public.tblslot DROP CONSTRAINT tblslot_pkey;
       public            postgres    false    223            �           2606    17979     tblstatustype tblstatustype_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.tblstatustype
    ADD CONSTRAINT tblstatustype_pkey PRIMARY KEY (statustypeid);
 J   ALTER TABLE ONLY public.tblstatustype DROP CONSTRAINT tblstatustype_pkey;
       public            postgres    false    225            �           2606    17981 &   tbluser_feedback tbluser_feedback_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.tbluser_feedback
    ADD CONSTRAINT tbluser_feedback_pkey PRIMARY KEY (userfeedback);
 P   ALTER TABLE ONLY public.tbluser_feedback DROP CONSTRAINT tbluser_feedback_pkey;
       public            postgres    false    226            �           2606    17983 ,   tblusernotification tblusernotification_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.tblusernotification
    ADD CONSTRAINT tblusernotification_pkey PRIMARY KEY (usernoti);
 V   ALTER TABLE ONLY public.tblusernotification DROP CONSTRAINT tblusernotification_pkey;
       public            postgres    false    228            �           2606    17985    tblusers tblusers_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.tblusers
    ADD CONSTRAINT tblusers_pkey PRIMARY KEY (userid);
 @   ALTER TABLE ONLY public.tblusers DROP CONSTRAINT tblusers_pkey;
       public            postgres    false    230            �           2606    17987    tblusertypes tblusertypes_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.tblusertypes
    ADD CONSTRAINT tblusertypes_pkey PRIMARY KEY (typeid);
 H   ALTER TABLE ONLY public.tblusertypes DROP CONSTRAINT tblusertypes_pkey;
       public            postgres    false    231            �           2606    17988    tblblog tblblog_orgid_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.tblblog
    ADD CONSTRAINT tblblog_orgid_fkey FOREIGN KEY (orgid) REFERENCES public.tblorgpage(orgid);
 D   ALTER TABLE ONLY public.tblblog DROP CONSTRAINT tblblog_orgid_fkey;
       public          postgres    false    220    209    3246            �           2606    17993 2   tblcommentsections tblcommentsections_eventid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tblcommentsections
    ADD CONSTRAINT tblcommentsections_eventid_fkey FOREIGN KEY (eventid) REFERENCES public.tbleventpost(eventid);
 \   ALTER TABLE ONLY public.tblcommentsections DROP CONSTRAINT tblcommentsections_eventid_fkey;
       public          postgres    false    212    210    3236            �           2606    17998 2   tblcommentsections tblcommentsections_replyid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tblcommentsections
    ADD CONSTRAINT tblcommentsections_replyid_fkey FOREIGN KEY (replyid) REFERENCES public.tblcommentsections(commentid);
 \   ALTER TABLE ONLY public.tblcommentsections DROP CONSTRAINT tblcommentsections_replyid_fkey;
       public          postgres    false    210    210    3234            �           2606    18003 1   tblcommentsections tblcommentsections_userid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tblcommentsections
    ADD CONSTRAINT tblcommentsections_userid_fkey FOREIGN KEY (userid) REFERENCES public.tblusers(userid);
 [   ALTER TABLE ONLY public.tblcommentsections DROP CONSTRAINT tblcommentsections_userid_fkey;
       public          postgres    false    3260    230    210            �           2606    18008 *   tbleventpost tbleventpost_eventtypeid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbleventpost
    ADD CONSTRAINT tbleventpost_eventtypeid_fkey FOREIGN KEY (eventtypeid) REFERENCES public.tbleventtype(eventtypeid);
 T   ALTER TABLE ONLY public.tbleventpost DROP CONSTRAINT tbleventpost_eventtypeid_fkey;
       public          postgres    false    212    3238    213            �           2606    18013 '   tbleventpost tbleventpost_location_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbleventpost
    ADD CONSTRAINT tbleventpost_location_fkey FOREIGN KEY (location) REFERENCES public.tbllocation(locationid);
 Q   ALTER TABLE ONLY public.tbleventpost DROP CONSTRAINT tbleventpost_location_fkey;
       public          postgres    false    212    3240    215            �           2606    18018 $   tbleventpost tbleventpost_orgid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbleventpost
    ADD CONSTRAINT tbleventpost_orgid_fkey FOREIGN KEY (orgid) REFERENCES public.tblorgpage(orgid);
 N   ALTER TABLE ONLY public.tbleventpost DROP CONSTRAINT tbleventpost_orgid_fkey;
       public          postgres    false    212    3246    220            �           2606    18023 %   tbleventpost tbleventpost_slotid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbleventpost
    ADD CONSTRAINT tbleventpost_slotid_fkey FOREIGN KEY (slotid) REFERENCES public.tblslot(slotid);
 O   ALTER TABLE ONLY public.tbleventpost DROP CONSTRAINT tbleventpost_slotid_fkey;
       public          postgres    false    212    3252    223            �           2606    18028 +   tbleventpost tbleventpost_statustypeid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbleventpost
    ADD CONSTRAINT tbleventpost_statustypeid_fkey FOREIGN KEY (statustypeid) REFERENCES public.tblstatustype(statustypeid);
 U   ALTER TABLE ONLY public.tbleventpost DROP CONSTRAINT tbleventpost_statustypeid_fkey;
       public          postgres    false    212    3254    225            �           2606    18033 &   tblmanagers tblmanagers_managerid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tblmanagers
    ADD CONSTRAINT tblmanagers_managerid_fkey FOREIGN KEY (managerid) REFERENCES public.tblusers(userid);
 P   ALTER TABLE ONLY public.tblmanagers DROP CONSTRAINT tblmanagers_managerid_fkey;
       public          postgres    false    217    3260    230            �           2606    18038 "   tblmanagers tblmanagers_orgid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tblmanagers
    ADD CONSTRAINT tblmanagers_orgid_fkey FOREIGN KEY (orgid) REFERENCES public.tblorgpage(orgid);
 L   ALTER TABLE ONLY public.tblmanagers DROP CONSTRAINT tblmanagers_orgid_fkey;
       public          postgres    false    217    3246    220            �           2606    18043 *   tblorg_follower tblorg_follower_orgid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tblorg_follower
    ADD CONSTRAINT tblorg_follower_orgid_fkey FOREIGN KEY (orgid) REFERENCES public.tblorgpage(orgid);
 T   ALTER TABLE ONLY public.tblorg_follower DROP CONSTRAINT tblorg_follower_orgid_fkey;
       public          postgres    false    218    3246    220            �           2606    18048 +   tblorg_follower tblorg_follower_userid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tblorg_follower
    ADD CONSTRAINT tblorg_follower_userid_fkey FOREIGN KEY (userid) REFERENCES public.tblusers(userid);
 U   ALTER TABLE ONLY public.tblorg_follower DROP CONSTRAINT tblorg_follower_userid_fkey;
       public          postgres    false    218    3260    230            �           2606    18053 '   tblorgpage tblorgpage_statustypeid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tblorgpage
    ADD CONSTRAINT tblorgpage_statustypeid_fkey FOREIGN KEY (statustypeid) REFERENCES public.tblstatustype(statustypeid);
 Q   ALTER TABLE ONLY public.tblorgpage DROP CONSTRAINT tblorgpage_statustypeid_fkey;
       public          postgres    false    225    220    3254            �           2606    18058 ,   tblparticipants tblparticipants_eventid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tblparticipants
    ADD CONSTRAINT tblparticipants_eventid_fkey FOREIGN KEY (eventid) REFERENCES public.tbleventpost(eventid);
 V   ALTER TABLE ONLY public.tblparticipants DROP CONSTRAINT tblparticipants_eventid_fkey;
       public          postgres    false    212    3236    221            �           2606    18063 +   tblparticipants tblparticipants_userid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tblparticipants
    ADD CONSTRAINT tblparticipants_userid_fkey FOREIGN KEY (userid) REFERENCES public.tblusers(userid);
 U   ALTER TABLE ONLY public.tblparticipants DROP CONSTRAINT tblparticipants_userid_fkey;
       public          postgres    false    230    3260    221            �           2606    18068 .   tbluser_feedback tbluser_feedback_eventid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbluser_feedback
    ADD CONSTRAINT tbluser_feedback_eventid_fkey FOREIGN KEY (eventid) REFERENCES public.tbleventpost(eventid);
 X   ALTER TABLE ONLY public.tbluser_feedback DROP CONSTRAINT tbluser_feedback_eventid_fkey;
       public          postgres    false    226    212    3236            �           2606    18073 -   tbluser_feedback tbluser_feedback_userid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbluser_feedback
    ADD CONSTRAINT tbluser_feedback_userid_fkey FOREIGN KEY (userid) REFERENCES public.tblusers(userid);
 W   ALTER TABLE ONLY public.tbluser_feedback DROP CONSTRAINT tbluser_feedback_userid_fkey;
       public          postgres    false    226    3260    230            �           2606    18078 4   tblusernotification tblusernotification_eventid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tblusernotification
    ADD CONSTRAINT tblusernotification_eventid_fkey FOREIGN KEY (eventid) REFERENCES public.tbleventpost(eventid);
 ^   ALTER TABLE ONLY public.tblusernotification DROP CONSTRAINT tblusernotification_eventid_fkey;
       public          postgres    false    212    228    3236            �           2606    18083 3   tblusernotification tblusernotification_userid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tblusernotification
    ADD CONSTRAINT tblusernotification_userid_fkey FOREIGN KEY (userid) REFERENCES public.tblusers(userid);
 ]   ALTER TABLE ONLY public.tblusernotification DROP CONSTRAINT tblusernotification_userid_fkey;
       public          postgres    false    230    3260    228            �           2606    18088    tblusers tblusers_roleid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tblusers
    ADD CONSTRAINT tblusers_roleid_fkey FOREIGN KEY (roleid) REFERENCES public.tblroles(roleid);
 G   ALTER TABLE ONLY public.tblusers DROP CONSTRAINT tblusers_roleid_fkey;
       public          postgres    false    222    230    3250            �           2606    18093    tblusers tblusers_typeid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tblusers
    ADD CONSTRAINT tblusers_typeid_fkey FOREIGN KEY (typeid) REFERENCES public.tblusertypes(typeid);
 G   ALTER TABLE ONLY public.tblusers DROP CONSTRAINT tblusers_typeid_fkey;
       public          postgres    false    3262    231    230            `   �  x��Y]o���V~�ۻ�>(G��͐؉�9v\�u1 �@���J$U��*A�CW4AWF�J�zN�%�d��������Kz��(7���E���9�9�|m��]]���ܵ�G�^<ܷŵ�a ^��B�^��D�=��ǡO�҃����nX3�7|f��?|��ʥ��7�ys:�'H����g�3��YO8q�8����h�e����B!��a�s�?�X��/H��Ek�F�=_����M��K�x,�M�I����(�Bu�>.�ѷ�����D��JݪOke�%H��B�Ξh�"ɞ�z��D��|'��Ꝏ�C�O�=X$/���7|ly@Oز�@{�?���AD�x�d��ї=:��~rb(C������mتC�H�,c�Qd�������l������K�xh�o��ɱ�Mz&$�#x��eC�M!覂�n:���$�����ѩ�s-L;���Jz���n#&�		u�A�M�&{�BΓ��~�Xt,ߋ��NS\'.t���fގB醲7�崋עY.�G�n>��/lΗ��g
6k���|0^�$��x�?	"�X΍tZԽ(�	�B;U��pX^Һ�]C��?��#-e�2�|��i��9�zz�k��%=~.�I6]r"݊9�$�mp���_��fs,~vɁ0�-XviE\�A*����1�Ue<n�AධԤ�qzO9��)u�ހ��8LeU٠�D�T�,�۰?`G�N,%��:$�.g�KO�lM65�h�)�N�㴩"?&��K�[�-�:")H2�Ի
��u���rn~s��pq�AFzb�����j!Vkb	�<R,Ɯ+�qz�X��9�΋*��"��''��L�|�H��a���2s��jr�P���"�h2��*ɮ!1}-���� Y%�"�>�_K�6!�ǕE_79v:x�+�Ҩ����Jg�I�yDW)����Z��v�QT�a�_;Vشj�9�<ɬb]���(L�!`�tU +%�}���Y]l;nB�R��
UAnvmm�gW"7��8�H�m$,�"+����#
/]
�"�<+���@�I-P<Ȉ�`��6�;{j��;�<�#n��w´"�!cCc�E��!3g���>����f��u&4����f������e��2�[�M�ސ d������*}�,��������9d����b
��������Fe�OY��Z|O`@��<�0�$���G�^�_-�6��4R���P7و�EU�v��t ��2j�*�U�Q�N�i�y�A��R�(R��+,@� �%�5�]�>D����Y�A\�qP:�����+�m[ȐL[1�/�9��x��@�#�J�1ag��j`I���Ȯ�����,+Ur�z���PY�%&hfE��*Q���Q���!��$ʱcnvzo���pħ�V�H���epWslg�����S^ghQY'����X�b,fF��
������ց���Q��(B�U��/�5B��c�P����I���M@`���jB^3��b��F�M�GX��=�c:�9#�����;K�Gc���ގE'V����Aғ�8� N=�4 4"�~;ܔ 7*���Re�r�\�+�q�4k�L]tg�f����S�U��Tg*��c��]s�d�N�����\~�,ݪL����p��6d����|�b�`ل뚢eb��)�Am��ݔ.� dm�5��74\��u9���2��zFL/cFA����E��YV}�}�/d��v6��~��l���7��YBZ��*arAn�@oD)��2Z]��,�R �\Խ�|��s.�p0$`wU�2R���$��B���L�@�A!�)�]�&oΡ�w0���� ����L�\�-��?� 
?Hxt�j���&	g͸���0(�輻���)�J�f��������A�iD�b�q���;��iB��Px�45��b4b��
0U���=���}�UQ���a����>J��e�J_��!B`�
���^W�WɆ��V��a�5�'��t+l���:������@����؞�D��顥1[,�#_`[0VU'�)?��{���0���GH�4�#��� �,�-X�*n��m�b BP$�#�N�.���|9���C�ln���������p�A�ǟ"\��D �	�>���@_�𙼍���#y>�8�+:��t$�g�=���
St�.kN@�
�_�ƕ|i6���5����(��^����l�)*Ѳ#f�i���W>�9�>�H,��ZM�%�Z*Y8�?� �<n"��Ɉ���Ha�켖ͨޅ^w����1^Ct�'���\���k�F��*ń�r�$��jɸ�5��T�~�u��F�JUd�G��d��c�R=9ֹ��(t�q��u�5�To�)=�Tz���|o�6t'�d�Vk/3�*=��R�ǋ�)���swU+B��I��mm�߇<I8{�*�K�4����� �šCtXi�mb<q��^��K�a��@�%դ=|vL�H&B�~<����@�mJN����P��s.y�	}$��,�|TY��cu�沠�z8���{�u}�X����%�t�3a1C�jS��߂h
<*y����",�V��������Y��d�C0�plA �s�� ��+��W>kK��?���3/������p�b���"}X�l���V�|p}cE�&���kK$HrWl���{� e�.��,��Z�g{�}���߭�����{�������8���C��{㪪�̌��?r\q)���%�����8�� �^pǈ9�����(�n�7�-�sB���b/��Q]":0����s�B�7��9J:���@&�|]�7��h�5Ob��oI_.�Uti�<u�9A[�U�� �J�W����wP�G���p�)J��q���k4�aL1ޅ���/R�meT>H���m�幇�|�.qp���m�Ǥ]A3
	H9�J�I�)���y��j�i��6\����Fx�e�ͨU�U���t�D�-P�`ފb��;V�w,�G��N�
,�����L��h�Է����&�=�� Q�t�������Q�H��r،e�z,��H���8��ي�m��tUղ�Tp�#�ײ�p�]��m��v�o�a�����c_��rwhm�B��H�&(=b�Y���(�n�O���|A�l[�e��M��q�����Vf�������
I�Scd:b��2�q�J�Q�9�i��v�@vR��R��i��J���a>���V���7�Z�mQf�o��Ò����l~zj-�Y���K�a���yI7��#cb��z(�yӒ�Q�o�0�Uw;�R�/��+s�*�=�l�,���w�4�Q��@]��
�10`?�~�P��rf�*����'~�����A�N����5_��9o��|�?�ӏ]5�Ïu�~R47c*2N���K�l��p�F�?��Y�      a      x������ � �      c      x��}ko��g�WL}�����~	4u�,��%J�|�!�H�39�ȡ$
������M�8M�$M�Xq�S'q��i�H�-��������p���%�i�7p�/s{/k=�Y����jY�L-�3a&��Q2���9E�ɉ�F�<x�P��'ǿ����%��/M���Ċt�qi����R���5�\.�H�n���"M��������V���s%��<��v����n��� ���E��c[�;��Y�cA-�5gL�m�Ι㪭h�b��n[�e*����i�憥ٺa��c*�fY�e��صv��Ae���(��T��������ߺ~�K�k�N_[^��n3�_�/�6�������<���'k���{���dgg�A�{�3g6�����,o������`�Yi�m��/7\�z`��ʶ�����efe��lO(�~��V�S��'��Ō��2e�����47x�����uiJ�=9�Е8t?�����'�w+����9��O�_���m�zr�at�6\��H�^K����sr��T��RH�,����VKRӅ����D�^��L߯x8w/��� ��IcR�C0x���>�I͓�7���"m��wr�RE�������.�d���E�����C~w99�Wy6��F��C��U�-aO܆xІ��J��JV���V������F��
�P�H!4�B��<������un�K���zz�l�Qd�G��e+3�O)�l�[|�s��)̔ץ�����4?x3/���H���%Ԑ���
Ry	�d���Ό�zr�[<~r��+��q�g�&Kei9?3�P�r�����4=�U	U
�������UG��Ew,K�U��[��lӰtMq�pL۰l��W�jm��X�\����5{�6wq���J�J5��__�d��Wm���F��Y۹81?�Ykl.�	}��0e�YU&��
V!�ÿ��3����z&���?=�4�0� Ѕ>���N��58�Y��|H�V��'�?���h���>����(ǃ�Ҧ�B�8�-�$��ؗ}A�f,~^H��<��vO��TŇ�͏��p&�#<ZT���O#aS�Lay�mb27A�?�Q�F9?7��,͞*�OK*��~<�sq���%ipc���c���:J� E�cB��J��c[�p�V���n�/�a�;���j{�q�g���u�K�����(!�V�p�R��9�����4�]�m� ���/�㋗���]�7Ae�;}tĹ�78A����"Pco�x�+<��Cć��B_4�8_0���1.,�% �����^�g�)���%�d��� f?@����� <A�<=�B�=�֊78B�qPI�)����G�� �tOlb+�� R��Kl�!����(��0�hhD�'�:��O<,�t���@+����n"Ba���=�ݧ���{�rM\,�A�������{nu��p�|������{��� ����j0<�J�Zc�U����������z^������wx�%~�+������7��x�%q����n
5
�Όtye�,�[�����F��Z�f����EI����1�Q�(��-[�j��h�a�Qӱ-��mS�s7l?S�9��Ѷum_����	Ȟ._]j.7��V%��Qj�\�}7Ȇf�,�jIߞZ/oN�
ver"l��-�v�{��W�h�,�|٦�Z<��B/�{����He����S7�:�����]bC̾ L<aE*��3`�
�La�rAF�Ix����N�a;�fl�a��bX�^�lm��8��Țc;�
l�R'E~�N��W��Z�+�-�Csn]��k{˪S-���z��V���^�_m��[�~�_Q��_�^�"l���L���K2�]�= u�"�~�����0�-�I��%6�2��0�F���H�xv+^��Ľ�`vZpg�h8���BU ��+>�*=b���h�@��#��� iMi�4��^�M��`˨����B�ٔz�M���3�����H�'���L��Ճ��'���!i���켴�������w�����Gep]�ڗ�V���s�(�@���=�h,���~�+�u��k�hٍi._&���h�h*�iٺj��eن��B�\c[�M������^��oU�Ku���E�~��ToJ�kW���Zy�>�������KJ�[�4����A8�9��25��h.��~?��a���[�t��Y��t,ib @ٽDϑ�8B^�CaUbS ���	��ZpqH�>���~�A����;�`X�C��!��Y�k�����_
���KP)<_q}z=��k��I��ޑSѠ6���tg�7Z��-"��]?+]�x.u�X<p�U��?�m���܀4���q�$m��s=R�:9��C�`f�B��n��,�5h���sӍ�Y�M���Su��s�L1�������2��y��3��@��F�j!��,�[����q���t�����w9�l�9��j*c��9g\�U�F%� ��8�ζ��o[�eGv]x��˧�6c޼\X�N�V��f�V������-�eo�ҝ�+������z�S�/츝�ٚ7VW���D����fDT��4ƙ �Ww�< {8�g�G����m��D��49�C
����"R��{di���#a�"G��{=ɐ*n��������d�n���þTv�"?�K
V�t[`)b���`-���K�r�mb�@��@0�����BA�����} ��r�k�aOJ����_a��`��0>�6�W]�kU���^;'fs��n��jw6.xr���ٹ�n}N1M��5��}U6A�j���s���4�
[M��^+�~��M��t_TP�'��[�A���N�"�r����-�z͡�>�8`�&��8&�c��8���L`U�M��M�]��Pt��sOu��a{��#��D����kF2z=�32�G��a�����.^����i=~!�0�џ��%�jVNIx�z&��0,aXS?�σ�&L1����.����y�!tK��dT}�-݃�����#_���p6��P�= o����C�M��C.(���߶�7q@>�!6g����Ђ
L_�k�����D�D�����N�m�X�Xׅ1!o
�Vh~H`;Q[)�F��j;Gu)�>����x:] P($#���dxY�Ŕ�=�R����M�G�H7y�GB3� ��t�x�F�� h�HM��&����)*�2*�
�{�d���t�Q��kU�!������ >O������F����*5��ܰ>@fI(*�L��N:��'��/���zMZ�ka z�I������L�A9�`���r��6Yg��&xڡw�e�yD
�"ɮ9�f�Ĉq����1IŨVz"B�b(��� e('�Ě�u�5y\��I�~�[0���(���H�qP*I�K��¡�#���.7�C�KD�� -���hF�c�yx�'�yW$J��N�M �a�r�X"H��p�K' 3�����D�d��řɹ�4�Vj���V�R����4M���K����0zݼ���%xB���}�/��a��{@���b
�+���%��{˧a�0������g�y��#�{4��-xT�Ï�M4�$��P4�1I�R�Dd��u�����u+�0�����d��c��A��P�7����/�:�2�����fQ^.��ʓ��������Q�{?��z�x�o�PhSa�����X"��7�c�v��V�R� c������9I��q�oϮ.j���K��,���TV������R���������X;��s��r�[�usDӆ)�x�Ӗ��/���*��`�	�:��.�9$�}ӏ	�ij�"H��d2oCn
t�������{|�������f �}|z��}8Z�J�����b�z|�g�	�@K���>pkd�?x̮�c���Mb������3��B�����0:���q
)5P��𫟍�U��v�n�
����cǹ�    �3���{�!]A�:n*J��;�[|�#�E�?��.�#�����3R:-�+�P��8ɱ����e��cDJ@�N�Χ���h�,#��j� ��an�Ca�ɍ���w�^D��9!�1A���K鰒K8�zĦ�"���N���������|6���_��K1~���H|�pš�$!~��֢�&L�C��H$�>'mC*".�C&�L��Dp�J �jW!P���)�A8��H��S>p�1&=$U�2Rq��qDݗ-	$`�M4<�!f*R�	
�x|чP`�}4�����E���l�ad��S�ףl�>��<6MF9�qI����hu���H�����e��>��EÍ��y��ɜT�~�'�N���4ԅM�ɃPt��)�.���UY�Pd�Z��:xXaq齋n	���vC4N�&h��ŗ>q�v4�	w/�l�ˑ���N���@����wܘL����$��m�T=�c��E��n�r��2�(7���-��@�D�Ebp'8�^�m'V21uM���P�����4gTVe7�e"8"TG�L4]��#��>�������⦟4��B+9SCMN@G�도�EV0���]�R�㱎�LVZ���J-��ԥ�ZMd�[�ގTy{p�?$�LZ����F��Hj�·��+�z�`�T ��6�"��a���W������6�'�à�,����B��u���y���H�w�Ub7�RР�@�N�|4�bn����ɔdB�19I����w���N������]<s��NtL$d�oI��y�H-���@Ml�L1n"��A�����x�39%t �"�~�1:�.1�o� ��!��ZA,Ni	���ϰn+n$��S���F���R��|ܥ�'�f��s7�&<����1�nNM�YM�W�2`��[�G�g 	;���A,�Q?�$���p2)c�y`|(��]�\����KL��Vc�cZ���c���>��V0�p`Ӂ8� )�)
��I�!�8�E�Oc	�	�"i'6�9��!���0��J#��q�T \�t�:�6�����8͞�de�7���$�@�0�-ƙ3'�g��O�h����(_-��fbޠ�A��y��K�v��6H=�植��Rt���e�U����)��3%ii��4�/st�jZ���?[I�#��yU�F���t�e:�n�چb��8��;��Zֆi��aˆ�9��ʺ���ꓲ��ruzyzA��ל��S�|f�C�s���Ur���t���W�~������S3������J�N���D��ɓNF��	C�������~�|�2�q1�	!�$HE@�#!���	�X,�!�/i��6�!v\������\MǇӮ���2ǒ"s�+v1[��{%;����'1?���*RWa�Axtϥ�'���E�}�S�l֙4�;1A݉:=��:Ȥ����s{\�R�&R8^����"�X��&Ƥg;�wFڅ�'�:v�9C��-1�ʱlqٯ~'MS5(���)��b�,��X$��Hx\�d�G.�Km�̻1�c�`���f@� ٹćhŇ�!?�h2��4�Π�"�v	
��˘5:��A��H(0n3�Az��qP��W��XY�(ሖ=7�/�p>tXO�dPmG�eCUGu,��S�deC��T-��TC�t�����t���fm3�-߸��]����5۸R�98:�ty��]o�`����l.��w˻�^�^nmM\�[w��ڳk��|��|1*dP&t� �P:~�Q�ьƥ9��3_g�4�I{-.�1��bA*c�*."�v�~�BZ�!��3�"D����w����s��%�߀�?�2�O��7����x���+^?W|"��1�^*�ԏG �g�@u�zqT���8�@�Q���CT�+8���Q̜cK�G��Dܾ��9:'ǿF?�/'oT�>�2}qz�$M����Nv i2�&2�?#�V�D�ruW��N�L����1+����FXJ�"6p�'����c
L`�]$��s�<���V�5tر�Le����ySώ��I��( b}���X�(�g�8B�����MQ>4��2TGA�t( �?B�뒍�3�7�q�'��&'��yc |�,��J�
�O�����|�ϸ4�Brl�|�� �Y�N֣��a}GR1�������J�f@��`�KVMUF�d:�f��njX*[�#�lX��)��j�.iO��ۍf�)�t]{��A��8��%%]��ԭ��N�^�8U�WV7�z�0���;���D�0�5U-NA72L�R�a��������w#I�?~�]�k��(��Lqs��(�
!.H__�����f�4m[՜�R03V��Z�.VL�s�dq�Zi��T:9�x^��R�na�}yi�4-/(�����U��J˼����`X|�e�����R�Qef��-UN}nE��DQ�6זGߑ����O)��<�ا��""ByNVh�?Z��M�2���Fq�}@c�~�)W�D5��4Q�d��"�B!lz�&�6�����R��
M��ng����IC�e�墓��*�o�~���W_�=\B+G����숕�.3A҂ n��Јy����@��?r,;8E}��T���T�r��s()�QE����8"i��XG,<�D!��(ۂs����s��QB��2��x�����ᠿ�G)U\+V����_�����/������1	��d�E�%��[�x�C�i�6���3�w�,Њ�P��q���SCy=I��S)��c�k�"lR!��:�{��������YsX٨m;�aX?����ʀxQJ��a��R�E�{�h\�6������^o�����	�.9ᢧ?��_Ói 9�h76�)js��b�
������"+���,9Ԡ��;^�F���ͨ�o�.`�^;wիzVn�v˺�i��aȲ�:�e��i겳���m븤J�M�K����e� ��2�r*�5g���d�L㭎T�ڥ��ᥫ�;W˭g��˦�ts^w��X��?���bůGNe^+L��3�2����`�#,s���ډ��9�ˍ1�#�ʴ�xf��߀?�'G����3�҅oY��D�Z�n*�eɎbڲf��nX@�Y�5�40�,��c�{?�\�ܱ�Y%������y�\FHx�e_;��O�L�.h������u��3���S�z{ߛ��1�萩L9TI���σ�<?Z�׸n���W0��z��<�	�s�-�t	��Ȅ���px���;=r��I�dӖ&zv��#V9L� �����Eᖢ�b��.��(�ϡʐ��
�Y=9~9R-hK6�����IЂ�QaQ�}0yN��q�u:�A��k,��3���� ����Il/^����n\A����&"��8��{HC՞Tz�Hq9���?CI��%��-�N���)\z/btГ�A�����4F+7�OXz���T�c4�ND��K��]�*)���:�V,��q1p�+$"�Ѿ#A\�S�\1Nfq�k/Ba��[��C�T\8Jc�p[q���B.�3Ɔ:�� ���!F6�2�Ģ�����i�3�R�%JC��=D�rT�
�pY�ì�<������Cyݯ5�b�cۃs����E����h�3�)\�u7��%!m1��Bߩ/bK,��$�/Ȟ0å���*ڇ�#Q��y9��(�rUfp !��a�~ΫK�U���W`�J+U��	#m{-�O�F�nV7�H�q��)(�(����#�p��_P�L��t��D��0.��u��	}BZ���\����N��64ƉR��YIU�%�3�>�֫��7x��v������zI��/$�o߂�/��-]q-��[���@�o}�_~/����S�~y��]����޺/��?G�,��i�8�Y��g��	$5��o]	���b��:�d�1��E?�O"AGHG�qm{Kc���F��������{�$V�nK��Q�)7./���Ԅa�Ru�n�����Ü2V��u�n�ML~�u�1^ �
  �jll�mk���Êqq^�;j�r���{pm�=��'*��l{~�'ڔ h?�&E��jI��9>�ߙ������O��l�Z�^��K.�\Z�=��h��@�'�<8ȴ�<�^�5;�̵V���v`��n�s�����܆%{��v�~/���H��ȏӐ�
"O���i뺅Ad\RU14���l���UsdC�e]UM3��cϯ��3�a>���:pQ��F�L��+{ٍ(��f���������A�����Qx���Vr�2���>�9{����m��q���nh�"�E)ڨl\g^��n#e���0��|�=���������g�K"��h�-�ϣ0?�(uxF������-�Kiy�jj�ũ�y���&D&<*r��&�����hA �;ٳ�����3*����'�r��ska��Q�w�ڒ��"��s�96������=�W����Ij��{��X���n��l�V�Ļ��S��,� ft�BE�yX,���`�:�8�K�EnhV��5Z��/?-]��sY�
�ڹZ��(!/Q3� ���ʢ��|7�ć06��X$�t�)�L��5Wi٣�r�6mx�#V��!�A��S+��"�e'�5�,&��D>�9`���C�J�hF��-{T(��`�����X_�%���a|�E�$,F���
�W��U��� �a�`�^�X~�T֩���'-����&�1�
W6SAv�����u"zH�W�Bi�w��MB���\�Ϗ�|ϧ��=�_�+"��R��/� �N�����O]���K��P��ĉ�k߸.M������dne.\�N�~������"N}�.-�~���~^���X���b#G�Lٲ,SsӐ74�����-G�u[5�؃�k��>��������ۜQ��	�ۥ�,���~��,{z�[X�KW��͒-O��YT��[�T����Vpe�x�|5��h�q@���B���]iV����b:�e�X���yQ�P��Vx�IZ~w��|����RZVEZ���pP)5�xt>yy�T�P$�\��EDW4i}�*G�?��~Q����m�ΰ��ldU3�x��'p8��q,^'�Z��SXm�b!�q{)��:�ђ�h{����z(�vy�N
���H��fV(!�A��8�/�׈�29�h�r�QRq�r����F6���6�b�J�FT:G!���q�_E�яBA/����J�Ң0"�V��/�7�q4�X}7���Zn�"6�v8�ʥ��q	oLU\�~ww�d�`h���mb���HQн��r5k��N,ߠ�.\����~Wz����`T��P�	#)�6K�����G}Pz�(z��-f�-/[-��y�pDi�D'�ٚ:nW�G���8��{�Ps�*��a�mbS�k�V�.J��B��E_��c�*r��`ĥ��(�Y�=�|P�&���Y<�<QUZH��<�2������鉶[��pO�\��Ӝ\Cw��~�g��Ќ����d��N�IO��COj�vk�׷���/g�29'�����q'����$��E��o��oX�XB���lj��k��[�n���uCQM]�u�b��c��#�Q�R�6g���_sf�^7�R����B�u%�-/o]��nue�35?4�;��._��T�Z;h��է.������\gyz�W���+`D4�+�!�1�T��G���� ��J��e�������c�JbӦ���Z~��mZ�Z0��~n��3��̥��mir� ��(�����'K7DY�8�H��D�����f��t���J�~�#u�q��E���Kg���&�/�9qXяHw�LoW@;Sc�h=��$䟹U�p�q=V��.�K�E:h!��ɒ�Ὗ�Rhc�.�X ��������K����ud��p���Cr^��q�h�D�(�8Y\�����O�2��lr�����Im�7,�=cYGz�.s
��BF�6^LQ���o1���)��q�/� �����y&�)�Rw���h���K(�\Q,��!d�S�*�ҍhaufh�11Ob�K$Z�����A�,�|?���c3��U�I�h�x+.Eo�����ކ.�z�aC�i��)�1SJr8K�d�Prz5»�p�"a�6!u"���N��~�f�����NXq��ة�C�ϭ�Ɵ_HH�/�yr��_J67ٴ�rI��=S5s�rt�RG7-S�4E�M>�Ar�Y�I���g�/��W���ϬM���Xu�s�������d�8s��0�K�������I]u6��=�+[K�K�b�mV�N�l,�MM�/./���cR�u.K>C�2?��+�gtM�sV�X��fU���G�r��V�����%���+����p:��O+�H�l�#wѴ4� �M�em�6��5,�qT��A����g��$���������uy&���ޛ�|�,
˭.��JK������Vf������KF���NN���n�	�� ��n&��8i<̉���	�.H���o3Z���
�bQ��� ��*-Loq'�Q��㝗�P��eV��IH8ȸ&hW�%���t������9��nB�>&��M.mKS������C
vx �_�3�����Xs �(>P�ij��(��o?�a���(^9��euË(�(��Q@#��£=�aОr�D�������턙5�R"�}v�G?���S��      d   A   x�3��/���/�,�2�)�|��9O����\��1gpjnf^b�m��\�Y�YR	���qqq j%      f   \   x�3��x�{f�BHѱw��KWp�Q82�ᮅ�
@��d���.#uNX�s^��PW�E�	g��]��2��=�=�f�d�jc���� D�IA      h   �   x�Uα
1���1��_bb%$�J��,,������y�!em�R���~}����xZ,Hq*���X��T�1� ũ`�X��T2wr'ũ`��1� ũ`�x 2���?q�U�����՞Hq*x;�~{�O      i   b   x�+)M�++�v�,�4�*�pC]��\S07%?1*o�呟��Q�øn �������������������9�Ul�C����kP֘+F��� P�(�      k   ?  x����n���ת�Ъv���{0�5ѲfY�m (-��Hj�Yd��YH��6��U�{�M�S�ru�N�
��aAe���=�9�Fo�Ks���ן�|���wvހC���77������?������ʻ���l~���_��t�|W,�b?LgQa7� ��������,*�"�d��mSNmKݙz�R��TW�1�Sl,���p�s,��*�a����`G�\���(W`�p�Q�l%7�ZA����E#�!�����&߂���������w��w�����;
S7L^21�h���7����iq[L�*P$��p��Q�ab8�`��t�$2��Ό1�:�Lq��0���tu�$���%h��fh������������ӱ�w�l��Oo��}F����!+��.]it����g����տ��g���r�q2����B��E�vN��x>���.)��M����{&���*�_ 䛹��	�^�Qy�^��I��ĩ��(� 0�I�@��1��B�&��)�DBp�nW��?�e��"e���vV�r��
j�6���_d���G�rh���U1�L9��ܵM�Ԩ-.��w��ѯ�U�X�?�ňS��l� X3�OЖ���v�4��a���&��L!���1cR��sA��	3�*t���(�_�_�����;w��+���u��.���3����*���dW���IW�}�vQ�1�qi}��%Ëh�������e�*��~�n���W�=��0���i����.����m�7~��غVg��k�y��A�v\誑��%
!�����y�-���6�|Z��.7�f�6
����Z���+����E
adR�%��
P�.�)��@s	Z�u�dp��A����"8:ht�����)^�ߦ��a_s����4�k�|�����z��:�t@�3M�Tq*���	��~�Z8�A�|8������0�m;���J���no��_��o�kp�8��p	kxu���p��0?�g��5�rESE�#+j
�	b�s q`�qI���P�I�/?%O�W��l����8����/Cmb�Z/�h7�M_wkA8����v1���i���7�U{�j��b��[��Qb?���c����Z����	��t\0���uS*
�uI��:c�<�7�o���cު���{�\_V���|����XZ�zg&GG�e䅋zu������cT���\�v���~��
�R���Dq�Q̎d�!�����>��)s��BEH%)3	���k0J�S��g&��$�QƯQ�<��Mcְ�T����Uf"XF�n'�����k�_$�q��7�=ԛ�:�Ý����J��^�;�0�h��Km���Z�$w���28?��������?��0�5Ŀ�/>T�lj
��ɪ�n�=\�c�&��Eċ�s�8����$!048hE�$��AI$�=���N,�O��a�8ڄ�7;ݫ�Na
V��3���T(e¤q$��:�*�S��WUr�u:b]�J4]'j�E��tP����_��I��`��w!-��}-����f�M��JG���p����>�݉�9n��������sh�DQ��!�R!����J���`�R��=͏W�m�[ތ���.�߮�=�|���ҤY�ÜU�ݍ;�e�fХ!��{�\L��k�˖����1���"�
]�uP�y9#I�����y���a/���BA<B��(61$34!Ju�ό��ah�+8�|nN���6��l\ƃ�]��F{�_�˞HV[46Bn���j�b���1m.��z;87�ɚesq��=�3RF	��pCxUx��� ��2C      l   w   x�3402��03�4�470641128]�B�8K8=s�S��=3���A�����z^�i\��tc�iL�NSl:MポC�:K��0��Ī$��F�n3CcCl&�%�nH����� �N�      m   =   x��-N-���w�t	U.ILK�r�q�t�)MR�M�MJ;��r:��f�q��qqq �]�      n   5   x�3�4�20P�U04 �\F���P�	�o�ih
�[��&����HW� �=>      p   .   x�sq�tIM���KM�r�t,((�/�\9R�R2�ҹb���� �|�      q   ,   x�3�4402��03�4�470641128]�BL9s�b���� �@�      s   �  x����N�0@��W��d{l�>V��m���B�(�J*H��
����=��'�IӚĠڹE����xf�O���x6RQL�	�'XDW�)Zd�2��_hU���Aߣ�@w&�Z=}�F=B�%*�� �{!�B*[x>�a/$�s�_��B&�����PB��C	�$���.��!C�1|*�0�'��T)�'��Gy���&h�/F�s4�L~�������biKjBX�~�.g�樛a5C}^3��+7h3�fR+�ci�v,��S�˭=��.�$)�I�O���r�囵s]<=.�s]�笂�?���w"�,�E��������,�ΒN����5m����͓luMg�&M���o|Yju�/ˬ��^��O��C$���1-0lN�}�$M�]Y�4U
(��6�ܨIt��ڊ�,���'k�%�])E��J1�R�༨F��������9�{����ߢ�6�7�𵢾�v��;e����|s���E��      u      x��ɮ�h��בO���積��3)�"%N"a���HJ�q�{o�+�<�0��^�zY��ԛ�SDfUugdgVW�E\\]~�(����w��J��~��h��ȇ[7�}�>e����|�>����0�FTe`�p��h�C1M��W4N�T&ȧ8�2�����!���o�)k&�Q&!�xK��xK��{���-ͺ�gԼ5�ܖou��Z�-!)��>ݻ�;6���×�ȇ��뼎��S��?�
����U��2���~}�e߳���j�j�e�`���]��ޟ��˸w`�{���T�����w�a��(�*ɦlx�&؀�s>�a�ۄ}��^��ղ���ǰl�9o�,:=U��7W�ͻ'���8!5m~?20���=�x���矷�}�_l@�؀�����ױp�r�>
Q�d�![~ΐ1���O�1o��tk�O�8I�OM6AOhOL��	�8�����M�c$��@U�4N�(JbA30NQF�7/q���&yO��{��$������kc�~3I|�>?m����Q�)�^�k�^eBz�7S����YiFO�(�C�W��/��j�o��{~g���h���F���d�ߌ��y_�G�H7[�����o��{%G�/�o�B��7��x���ys5�u���Glf������>���8�O$�oB�������8A ����4SN2$I�0M�]�0�_�ɿ����rf������`z_{�∾TR�X5vA��UT���'T�o���~�!(���p�7p�8p�7p68I�^S����?V���N>ƿ�������po��;�&i���w�1!����w
La�K�$a���8<䗈]v�Ѥ���0 �<�����rs����ѱo���4�ߴ�[�{�8�m�%:%�h8��q'uo�:�3\�o�OBAD�����V���>*eW��4w�%���5�!4B2@s(�� ����a�38F�SB�P$�� �?���չ�!�&앖/5�J�+��q��(�e�j��x'��%�}2�sT�J��w\����� 9��X�,��_�5?�o��/��/��7�Eޖ�Ċ��|���ʏ���g�s Ө,��ӭ�~8� -��vA_��Ba��`B��	LR� &�A�w0S)]g0%(�A���b���쟉1�:J��|d�vn�_%q�kn�O� $�Q�N��1(��c$ü#�>�F�gE	%)�B��_T�v���M�
�(��f��9����uKnUP��jY���XRO�yx]����,�7�1��	�)��(�
J�7J�D)i���{~m����(���Q#PV3�{�0 Gp�h��~Rj��_��m�c�<�+s����R��gX_@j	3w�ٰ6�"��!��j�r�L��?�@$�GJ�7J�����?H��|��[�j��!#p?z��l���:!��I�4�N�8L0��$F"@H4��(N���a����e���#te�\ .��/¯�[Ih%��l/��)�ݽD��no�C<�f���<�	��Gw�����ן������B`�U0R�P0�� �g��|޲�#��9j>�!>*��/?|}�	��Dc��`������]�O�W�)oۼ��1~ܭ�ջb�)~���в=�f){Y��Cu���=\�.P^��.�~dȷ�;!j>����ߚ�������������`'E����	��E�rnM�_��+�н���"�1wgٳ������3��%+@�,�*<��%�%N��KJ�#��%R�<�8 �P�,x-Uy�Q8|:^��xokm�ד�"ry��X����Y��������/�����$�"���>��y�|��xςX�U�Y�lpj���Yĳ�,��,؝� ���Ý�c���`=��<{V�������96g�w�m��� "n�"a���B�v�j+l����;�8�zR���h�GY���+����nC�n`^�|~?W�5���)DA����>^��ف�|X�U/�*��"��E��7\�~�8ZYg�ʽ��elGt�M##c�T?$����JQ��T�\�yOBG7/7�>�O����y��Y�}��U1�nZ��O�Ε��r�!u3�Yj��&3\S����Zk�E�c�q��b,��]_~����Ľ�BP�2�8�Gjo�ݰ�����7��]��Z���Z͋��놈��|7:�=��tߜcS��d��s����Xğ�x��3�-����h�M{Lm}�_')��|9���H�c)�{6t7�Ʀ�vQ59��D�'��Oi���ʤ���g!��a�4�i����{�TL�q���>W���iB�E�\�H�D����y��l�t6O��0�\Q����7B�X=��އ�6���rO�����TV����V�x�w��l����7M���=�U`FJK&ۇD[�cG��V56�h��?*㩵J.���ƫ%[��Z�?��8N~�
= G�����D&�Ǯ{+����E���gz����\˚n��ۖ�tn��*K�Q�U��"NwZ��N��%�~_b;�^Д�ʺQS�,�B�<s��T#�h��I���̽Ӂ��a��.F7��K�-*����j�S�7F��p�SC�1"�gH�~�o�I	��`!t��h�ׄ��F��,�����_<V�l=�D��_�TߜE���������<D�26��E�(���i�;s�y=)"�=��<�
����ڊNd�������w�.��WX�v��I!�k��z��F\6��KyL�]u�B���S���P�",���3�Oi�ƽ��I�5(��͖g��et�V3�����%[or��>�k�SHC��}hO7E��4��Wtd�D��mmVy>�،ݵ�bT��8��S�,��ݚ�|1)t[�^�v��-�|�Vl�����f�k��O��Ŧ�)�p6ق�4�G�f��QOa¸�xQu��X5���_������̜���s���rP��N�+��W�2�Cn�!T#'³C�ѧ˭8��2Vm��e�6��gt�Z����˝-�@�r>\��p�E�3cHQo�E0�<����ƷH��U��&S�>���"R�f@�eb��=��
.�0��a����7��E�3/��4�G��Y��H�e�����^WB��[����\i���v�RVzsl:�.YG����e��^��$�\��g���A��W�5�:����|�bw�<��]��*A!�y�y? z�u��
"����|X�U�3w�'�Z���s�L�b+�I��ުc�X�ʊ�g�-�.��84���Mqu�m�3n����Vm��IX嶊vֲ��U'8���r)-�f=qK����� �0��{�����O�{�=9��<�v�"}e-�V�c��3���T�-�UGH-�Q��ME^��k��YD=���~�B�0�
ڞq�;�l���:n�>���t���KT]�9-
����˳�ʽ�A<�O��)$��V�x�V�/��D�B~׊J�Ǹ��4��GV�x�ǥ �Dv����W�
#�v�Y�m \�S#?���bb�j��AN������i�SZw�hgt�A��y9�^��ÁTT�1���a���:��(�{w�9K=t�	� ��\�!˶�J��vdZ	�8��U����殻�;�A��;8�#��=��ink�m�8&��}�Z�Mtzf�Ja�M'�>^'��ٻjآw؆�l�vC-�]f6�v��h�8����hP�g�E�8iY��e�y�Y���J�@S�0�\��Ώk?h����~|����S��;�KOf5F�|����]�%���e�ܥ="��6���}��'٠�=.G�TdZ M�Tm=�0��h�q�Xn�0���|�27�F�8h����a��X{�䉽#3������i	�[auVč���;���
��Z�>���g=倻Q�P�L�f`VyR�T,t���W�Myם���}��!SBO��\LG-A]�
�����8~-{ #ł���s�e����k�D��E��U��?���X4�ܛ�    �}���#������a�lCøe�eM��W!J��.E��qw5�[��i��;�Q3��O��Ϸ�so�c�be��ߎsR��!<+��eC��UE��xZ����V��Wf���"��u����^��h���>��m.���JT�O�#l)���wx�rjq���
������֥"�Kߏѭ�C�׽v��'W�DYB6�>�&t�'F�ե�ύ�����Dç<�7���x����J)r�3+;�#G�QF`wb��d�<����t�&����`���Y�X� ��oM�;�B{��h��e�⇼ɞ�jӛ�1{Ч�Rz�y�j�U�8�:Cj^^V1O�vCp3����m��d!U�X���.e����w�l�!��	�Yl�LMb]呷���r;��ݕZ��n����fuػ�Fi��h���r��ZQi��Uf֠��:N7Ί�� Cޫ�F��8I �a�8�4�߯,��E�#��F>�[��G)���U����!|*3~~f�;���*�\:
����*�F��3R�1^�3Fڜ�����������"d��ыѲ[}��#��D<0k0�l�Rs�#�J�9^s5��	��*��TC��lࣁS�X�j׉��tp���)ua]�^�L���Vو��tNCX[�%��{k��A�·S�Ϸ�w�SH�Y� ��*�(4��f���y����Ϫ���s2B�YZ���G{8u��&F����L>��?�^�3E�lX>ygUz��A^�pk�lix�#�fD�Ae�la�rz��
��)�����sx�ܱ�ʴ�*�A�xֺ>���2�uQ?׭��5�j��F��)�e�}v�ie颽y79ٖf�M��G38�3��M�ۚʬ�D�������h�cW��= �̋�$�E��̍�Iq�0��� %�R���~yG���V���Y�[�������Aњ/&uY���;ʾo"ZP^A�t�[��
T��iB�l�TkR�焎�S�D\�."�E�P漤��mi)�-��|����X]�rY�K/�b<�����nQ���� �avD����+�H�?����TTޞ���NH?'{��nƗ�����רG!�$�C�R�׏�]R"KwQ�ߪ]�>6���B~�u��3�H��ڂ���O�!����γ�����j4՞�q�#1y��,d>��9�}ႜ�&��g䥂��f2��%���Q�*���d���22�R���2_��U��;dt2f�a�X؏��#
��d����l��i2Uwd�̐]��ZpB�i�A����:P��?���z�j��9��ږ�\ 良��*�eF,��� ;�X�q'�d|}@�	U���~ .�+���]�YhL�����>�C�$�0�޴��1��d<��|�X]'FGx��-���.��)uSF�������n��!(N1W��|L�О�גEO.��x���w�Ƨ��d#��RL�j��w=֦߭��5�	|���:&����&i�I����nl�)~"HY`��H��4�%b�\�d���tQ4-��*���=�U�K��T�A'd�T�*���d]f�Yc��2����д��Z�+K�����'���]���.���J��5A�R}�Y�z4h���@?p_Β��cQq�C��T�6+nO�3�Z�x��g���$�e4{vtK��1�����3�k�z��vJ/]��>:��Wٔ�ы���W�e��/�������L��c�9�:�X��f�ӡ�=�Cc`�Nn�Ǖ{��;���PBNs�E��΋ޓ�~���fٓmg�ou�@i��bV��mK�\�F����L}�򯞃�5��S�H��5+P|!+�[.�� %���>C���}�9��uV^O*M'r�v��g��;���J<�F6]N�"�E=��t3�d~#�K�ۨ%6I]{�����Tn�	[�u
�d[�'���?+�ݼ+`�_Yx�b�1�.!u ��E���Ng@}����|�R,&3�K�\���e�;ț���ڍv,&|��G��,{ڰ�ݯ=���AՍ���C詚�L̩��d�tT�b�#m��_MW�w�^���\�zw�G����t$�Ӗ�*���mbm���
�seR'���R^	�ڃ�"�+o�!���lH����m�g���U��Rj��O�c�]h/P�7�nG�;V�6�aMo�yF��ҳ�خF.��Kv��̂� �]��~�EO�����P&�I�{�1�0B�qL㤬H�d�{��<� t}u�A�����@^���# X��gt��4JuC:������F�nIF+_ju����q���4��Mn��#�	l����0��3�7k��Jv��@ވ�N���pׁ�Zƪ��Ӟ����ū��J}�r�שׁ*�a�#I(8���{.�L�3�T��1&����c�Q7��<b��o_m8��c�vg�:�Q�v�68���.RV��n�
��y �s��<�"�����pT�5�/]x�YV�xӃD����8B�Y�?"|���kV}Se/F#Dڐ(5NhT�zO�1��K�M�v��X���@���UC��EE���T)qP���ar'�8����\�(��d���g�g9j�aE��SݖmuF����<��a��6�R����G�����]ܞ�~�!��0.M�փ��g,�,�G�D�ǒ'�9�z��Ӄ�z"�@�g�(�����P��V����÷�&]%�:�l�{AB�ɖ�^�,so���n��.�J=���، �}� `�>ǺC_A��X�p������tdE]����<���� ����Ng�J�����?���)� �AG�:��lO������]�DM}���*�jB�w��6I[�b=�'��No��4с�����jL������R~��N9��	(���^pUzU�aɁHsf��r�T�I�U�8����A����������q����U�w�)�T䡢#�j�;�F��"��_��t��t� gJjvm��8{\��]l,�wI��6�=�(�fb:���/��?�0A�ҏ���u|�:KcrV��{z�+&��{�יW$Y��/�Y,ݭ8��y�u�i�D��b|/{����LևAp�9.�f�'v����i�"R�b�l����>��T�*�U֯�L��L�|����Y���r�nS�Oz�M�^7�$�{AV�7�����jN(Vj�ޏ��υ��g��*���h+6��n3D�A�Sˁb������E���E���%I�+������h�[U?���w$?sAU�n���(���(Fy.:aJ3l�<f�/��@DدfP)W7�U�)�vju���ؤ�yϨ��wWu�Չ�߄9Yn�Ď�j�sq�];EL2�f�����:��0���fL���l,X6�C����9��2��p��LM����{LX[&�E���qE��T.��˝��Q��y��Oj�\������iU���}p���#�\��)=�}]���5��k�߹�L���3~�D�5��w���?���n�����_�ȇ"*��s�|��������6���s��W�Q�1����Z[��ҫ�Dm�^ִ���9��G�g��"I�!Q��u?Z��%��4}�W[C���4~�u�F�DQ$�Bq�Bu�6���,ߦ�~���%�����E��^G`�� A�(:Z�wE���5�<���K�^|��z�z�e�?��?�?�Pg�1�B����!����8��$Jc?���S�}:No`�>b(���o��4C��i�Ba2���4C�y(1^s��͕�+�f���a(nkuU�T��=��G���2����+~�k}���o>�h��Ni��XT�u��i�`��?4���7��_���.�?����_ 2
�Z�Q#����({#0É�|��~#q8�:�(��jh��5�V�[S|8����c�K�N3����M �@���샖����@��4#���鏒��gG��.����$�BP8J�0	�/U��.�R(B ��8B�8��(C�L ��3A!0���n�7`�I�� �   �3
'���~��/��-����߿D�Cgث�����;�^p��z�R��x v����	��s�(�o��)h7��?�=��o��W��D �c0�߀�S e*������_�=����o��/�'���?x��o~����� �E���1��������      v   3   x��qu��IM.)-J-�
	�.)MI�+�r��t�-�ɯLM����� .&     