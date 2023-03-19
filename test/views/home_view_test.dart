import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jais/controllers/animes/anime_detail_controller.dart';
import 'package:jais/controllers/animes/anime_diary_controller.dart';
import 'package:jais/controllers/animes/anime_search_controller.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/filter_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/utils.dart';
import 'package:jais/views/animes/anime_detail_view.dart';
import 'package:jais/views/animes/anime_diary_view.dart';
import 'package:jais/views/animes/anime_search_view.dart';
import 'package:jais/views/home_view.dart';
import 'package:jais/widgets/animes/anime_list.dart';
import 'package:jais/widgets/animes/anime_loader_widget.dart';
import 'package:jais/widgets/animes/anime_widget.dart';
import 'package:jais/widgets/episodes/episode_list.dart';
import 'package:jais/widgets/episodes/episode_loader_widget.dart';
import 'package:jais/widgets/episodes/episode_widget.dart';
import 'package:jais/widgets/episodes/lite_episode_list.dart';
import 'package:jais/widgets/episodes/lite_episode_widget.dart';
import 'package:jais/widgets/no_element.dart';
import 'package:jais/widgets/simulcasts/simulcast_list.dart';
import 'package:jais/widgets/simulcasts/simulcast_loader_widget.dart';
import 'package:jais/widgets/simulcasts/simulcast_widget.dart';
import 'package:jais/widgets/top_navigation_bar.dart';
import 'package:nock/nock.dart';
import 'package:shared_preferences/shared_preferences.dart';

void nockUrl() {
  nock('https://${Const.serverUrl}')
      .get('/episodes/country/fr/page/1/limit/12')
      .reply(
        200,
        '[{"uuid":"81dbf2b6-aa46-4fc8-a536-ab2572041129","anime":{"uuid":"83db09c1-6e67-4fa0-bca7-e3888caaed59","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"The Ice Guy \u0026 The Cool Girl","releaseDate":"2023-01-04T16:00:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/ba93ce07c6039e72a3ca7976e4b62e21.jpe","description":"Himuro est un descendant d’une yuki-onna ! Il vit de nos jours et travaille comme employé de bureau. Mais lorsqu\u0027il est dépassé par ses émotions, il finit par provoquer des blizzards ou se met à construire des bonhommes de neige et des igloos. Quand ses sentiments secrets pour son unique et gentille collègue Fuyutsuki s\u0027intensifient, cela provoque chez lui des réactions glaciales ! Leur relation évolue progressivement au fil des jours, au travers des événements de leur vie professionnelle. Ils finissent par passer du temps l\u0027un avec l\u0027autre en dehors du travail, mais demeurent tous deux un peu maladroits lorsqu\u0027il s\u0027agit d\u0027amour…","hashes":["the-ice-guy-the-cool-girl"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"CRUN-886526-VOSTFR","releaseDate":"2023-02-21T15:30:00Z","season":1,"number":8,"title":"Petite sœur ! Et Noël au ski","url":"https://www.crunchyroll.com/fr/the-ice-guy-and-his-cool-female-colleague/episode-8-the-little-sister-appears-christmas-on-the-slopes-886526","image":"https://img1.ak.crunchyroll.com/i/spire2-tmb/d0c8a44c439887598f576de1016ce1ba1676957521_full.jpg","duration":1420,"platform":{"uuid":"eb438d41-2152-4b4d-851b-cbb2c50201f4","name":"Crunchyroll","url":"https://www.crunchyroll.com/","image":"https://jais.ziedelth.fr/attachments/platforms/crunchyroll.jpg"}},{"uuid":"9be2aa8b-6139-40cd-9394-c741e4d4af89","anime":{"uuid":"49dc56c6-06f6-4b55-8123-e3b7d3b93158","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Vinland Saga","releaseDate":"2023-01-09T16:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/9bb5b744630ae41fe9e5d9c9cc7f8e14.jpe","description":"À la fin du premier millénaire, les guerriers les plus forts et les plus cruels de leur temps se sont répandus à travers le monde entier : les Vikings. Thorfinn, le fils de l’homme réputé comme étant le plus fort des guerriers, décide de passer sa vie sur les champs de batailles malgré son jeune âge tout en rêvant d’atteindre le légendaire continent que l’on appelle « Vinland ». Dans le tourbillon d’une époque troublée, la saga d’un vrai guerrier commence.","hashes":["vinland-saga"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"7c40ea6a-baac-4875-836e-066b0b8b5bf8","name":"VOICE"},"hash":"CRUN-891438-VF","releaseDate":"2023-02-20T21:00:00Z","season":2,"number":4,"title":"L\u0027éveil","url":"https://www.crunchyroll.com/fr/vinland-saga/episode-4-awakening-891438","image":"https://img1.ak.crunchyroll.com/i/spire3-tmb/7bdf5fc7a8294f1a220e4799575f348d1675100672_full.jpg","duration":1554,"platform":{"uuid":"eb438d41-2152-4b4d-851b-cbb2c50201f4","name":"Crunchyroll","url":"https://www.crunchyroll.com/","image":"https://jais.ziedelth.fr/attachments/platforms/crunchyroll.jpg"}},{"uuid":"b77ebbfc-a7a8-4be4-9680-216648552a10","anime":{"uuid":"2f6b4be0-5e05-4a03-ab1d-9390b0e51e11","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Reborn to Master the Blade: From Hero-King to Extraordinary Squire","releaseDate":"2023-01-09T19:15:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/2da763f6a9b0cf95bb9874d988185744.jpe","description":"Après avoir consacré sa vie aux affaires de l\u0027État et au bien-être de ses sujets, l’ultime souhait d’Inglis de se débarrasser de son fardeau de roi pour se consacrer à l’entraînement a été exaucé, mais il va devoir vivre dans la peau d’une jolie fille ! Réincarné dans un avenir lointain en tant que descendante de célèbres chevaliers, Inglis peut désormais se concentrer sur la maîtrise des arts martiaux. Maintenant que son vœu a été réalisé, Inglis va pouvoir accomplir son rêve de devenir le plus puissant des chevaliers au front.","hashes":["reborn-to-master-the-blade-from-hero-king-to-extraordinary-squire"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"CRUN-887109-VOSTFR","releaseDate":"2023-02-20T19:15:00Z","season":1,"number":7,"title":"La maladie des Menaces hiérales","url":"https://www.crunchyroll.com/fr/reborn-to-master-the-blade-from-hero-king-to-extraordinary-squire/episode-7-the-hyral-menass-disease-887109","image":"https://img1.ak.crunchyroll.com/i/spire3-tmb/9289fb10a6551074aee053e02460977d1676908867_full.jpg","duration":1429,"platform":{"uuid":"eb438d41-2152-4b4d-851b-cbb2c50201f4","name":"Crunchyroll","url":"https://www.crunchyroll.com/","image":"https://jais.ziedelth.fr/attachments/platforms/crunchyroll.jpg"}},{"uuid":"7b4a9ccd-d5d1-452d-ae43-e610d9a4e7c6","anime":{"uuid":"39e6e076-ceed-4712-a8c2-6c617834ac18","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Play It Cool, Guys","releaseDate":"2022-10-24T18:00:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/9faef32c186fa903db78a1fe0ab342c9.jpeg","description":"À première vue, ces types ont l’air cool et beaux gosses. On a envie de faire leur connaissance, mais on se rend compte alors qu’ils sont vraiment étourdis ! L’un oublie son portefeuille, l’autre fait profiter de sa musique dans le train, un troisième porte des lunettes alors qu’il a des lentilles... Malgré leur maladresse, ces types ont toujours l’air décontractés. Suivez dans leur quotidien et vous tomberez probablement amoureux d’eux, vous aussi !","hashes":["play-it-cool-guys"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023},{"uuid":"c0f034b3-8eaa-490b-8326-e7aec8f548d8","season":"AUTUMN","year":2022}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"CRUN-887400-VOSTFR","releaseDate":"2023-02-20T19:00:00Z","season":1,"number":19,"title":"Un nouveau membre","url":"https://www.crunchyroll.com/fr/play-it-cool-guys/episode-19-new-member-887400","image":"https://img1.ak.crunchyroll.com/i/spire3-tmb/6105f0e539c6c546bce432b50f3cd8391676908985_full.jpg","duration":670,"platform":{"uuid":"eb438d41-2152-4b4d-851b-cbb2c50201f4","name":"Crunchyroll","url":"https://www.crunchyroll.com/","image":"https://jais.ziedelth.fr/attachments/platforms/crunchyroll.jpg"}},{"uuid":"68aa105b-e326-446c-a287-ad68f512b25e","anime":{"uuid":"86b274a7-852c-4c4c-9f6f-cb97eab6d27f","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Eternal Boys","releaseDate":"2022-10-24T17:00:00Z","image":"https://image.animationdigitalnetwork.fr/license/eternalboys/tv/web/affiche_350x500.jpg","description":"Bien que rien ne semble les lier, six hommes ayant connu des échecs successifs dans leur vie personnelle et professionnelle décident de se lancer un nouveau défi : montrer qu’ils sont capables, en dépit de leur âge, d’atteindre les sommets de la gloire et de la célébrité. Ensemble, ils forment les « Eternal Boys », un groupe d’idols de quadragénaires.","hashes":["eternal-boys"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023},{"uuid":"c0f034b3-8eaa-490b-8326-e7aec8f548d8","season":"AUTUMN","year":2022}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"ANIM-20469-VOSTFR","releaseDate":"2023-02-20T18:00:00Z","season":1,"number":24,"title":"Eternal Boys","url":"https://animationdigitalnetwork.fr/video/eternal-boys/20469-episode-24-eternal-boys","image":"https://image.animationdigitalnetwork.fr/license/eternalboys/tv/web/eps24_640x360.jpg","duration":780,"platform":{"uuid":"aab7ec1a-f2f5-4edc-b9a5-5eb025e228c3","name":"Animation Digital Network","url":"https://animationdigitalnetwork.fr/","image":"https://jais.ziedelth.fr/attachments/platforms/animation_digital_network.jpg"}},{"uuid":"5795a3af-3bd0-4a6c-8c45-b42de7e772de","anime":{"uuid":"86b274a7-852c-4c4c-9f6f-cb97eab6d27f","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Eternal Boys","releaseDate":"2022-10-24T17:00:00Z","image":"https://image.animationdigitalnetwork.fr/license/eternalboys/tv/web/affiche_350x500.jpg","description":"Bien que rien ne semble les lier, six hommes ayant connu des échecs successifs dans leur vie personnelle et professionnelle décident de se lancer un nouveau défi : montrer qu’ils sont capables, en dépit de leur âge, d’atteindre les sommets de la gloire et de la célébrité. Ensemble, ils forment les « Eternal Boys », un groupe d’idols de quadragénaires.","hashes":["eternal-boys"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023},{"uuid":"c0f034b3-8eaa-490b-8326-e7aec8f548d8","season":"AUTUMN","year":2022}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"ANIM-20468-VOSTFR","releaseDate":"2023-02-20T18:00:00Z","season":1,"number":23,"title":"Le Budokan","url":"https://animationdigitalnetwork.fr/video/eternal-boys/20468-episode-23-le-budokan","image":"https://image.animationdigitalnetwork.fr/license/eternalboys/tv/web/eps23_640x360.jpg","duration":780,"platform":{"uuid":"aab7ec1a-f2f5-4edc-b9a5-5eb025e228c3","name":"Animation Digital Network","url":"https://animationdigitalnetwork.fr/","image":"https://jais.ziedelth.fr/attachments/platforms/animation_digital_network.jpg"}},{"uuid":"2a50dbb8-6354-4ae9-b181-337149af881c","anime":{"uuid":"86b274a7-852c-4c4c-9f6f-cb97eab6d27f","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Eternal Boys","releaseDate":"2022-10-24T17:00:00Z","image":"https://image.animationdigitalnetwork.fr/license/eternalboys/tv/web/affiche_350x500.jpg","description":"Bien que rien ne semble les lier, six hommes ayant connu des échecs successifs dans leur vie personnelle et professionnelle décident de se lancer un nouveau défi : montrer qu’ils sont capables, en dépit de leur âge, d’atteindre les sommets de la gloire et de la célébrité. Ensemble, ils forment les « Eternal Boys », un groupe d’idols de quadragénaires.","hashes":["eternal-boys"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023},{"uuid":"c0f034b3-8eaa-490b-8326-e7aec8f548d8","season":"AUTUMN","year":2022}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"ANIM-20467-VOSTFR","releaseDate":"2023-02-20T18:00:00Z","season":1,"number":22,"title":"L\u0027Album","url":"https://animationdigitalnetwork.fr/video/eternal-boys/20467-episode-22-l-album","image":"https://image.animationdigitalnetwork.fr/license/eternalboys/tv/web/eps22_640x360.jpg","duration":780,"platform":{"uuid":"aab7ec1a-f2f5-4edc-b9a5-5eb025e228c3","name":"Animation Digital Network","url":"https://animationdigitalnetwork.fr/","image":"https://jais.ziedelth.fr/attachments/platforms/animation_digital_network.jpg"}},{"uuid":"ce62ef7b-797e-4609-9dec-8a59fd2a15c2","anime":{"uuid":"86b274a7-852c-4c4c-9f6f-cb97eab6d27f","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Eternal Boys","releaseDate":"2022-10-24T17:00:00Z","image":"https://image.animationdigitalnetwork.fr/license/eternalboys/tv/web/affiche_350x500.jpg","description":"Bien que rien ne semble les lier, six hommes ayant connu des échecs successifs dans leur vie personnelle et professionnelle décident de se lancer un nouveau défi : montrer qu’ils sont capables, en dépit de leur âge, d’atteindre les sommets de la gloire et de la célébrité. Ensemble, ils forment les « Eternal Boys », un groupe d’idols de quadragénaires.","hashes":["eternal-boys"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023},{"uuid":"c0f034b3-8eaa-490b-8326-e7aec8f548d8","season":"AUTUMN","year":2022}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"ANIM-20466-VOSTFR","releaseDate":"2023-02-20T18:00:00Z","season":1,"number":21,"title":"Les Vies de Nikolai Asakura","url":"https://animationdigitalnetwork.fr/video/eternal-boys/20466-episode-21-les-vies-de-nikolai-asakura","image":"https://image.animationdigitalnetwork.fr/license/eternalboys/tv/web/eps21_640x360.jpg","duration":780,"platform":{"uuid":"aab7ec1a-f2f5-4edc-b9a5-5eb025e228c3","name":"Animation Digital Network","url":"https://animationdigitalnetwork.fr/","image":"https://jais.ziedelth.fr/attachments/platforms/animation_digital_network.jpg"}},{"uuid":"4665f753-e4dc-425c-9dc2-f466238abe55","anime":{"uuid":"5e8f5436-7723-4501-a7d5-08be7ef4288d","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Malevolent Spirits: Mononogatari","releaseDate":"2023-01-09T18:00:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/2e90fd53ee309d204ac44ab72d35b2df.jpe","description":"Rempli de rage contre les esprits connus sous le nom de “tsukumogami”, Kunato Hyôma est envoyé chez Botan Nagatsuki pour l\u0027aider à les voir autrement. Bien que tous deux fassent partie d\u0027un clan renvoyant les esprits dans leur monde grâce à des pouvoirs surnaturels, leurs expériences respectives avec l\u0027autre monde sont très différentes. Tandis que Kunato a été privé d\u0027un être cher à cause d’eux, Botan a quant à elle été sauvée par ces derniers. Pourra-t-elle le faire changer d’avis ?","hashes":["malevolent-spirits-mononogatari"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"CRUN-887096-VOSTFR","releaseDate":"2023-02-20T18:00:00Z","season":1,"number":7,"title":"Prémices","url":"https://www.crunchyroll.com/fr/malevolent-spirits-mononogatari/episode-7-quickening-887096","image":"https://img1.ak.crunchyroll.com/i/spire4-tmb/5f8059b5c5adafa7281684600e895b961676907606_full.jpg","duration":1419,"platform":{"uuid":"eb438d41-2152-4b4d-851b-cbb2c50201f4","name":"Crunchyroll","url":"https://www.crunchyroll.com/","image":"https://jais.ziedelth.fr/attachments/platforms/crunchyroll.jpg"}},{"uuid":"0c57c13c-45fa-4dc6-ae1a-1802a63ca84e","anime":{"uuid":"49dc56c6-06f6-4b55-8123-e3b7d3b93158","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Vinland Saga","releaseDate":"2023-01-09T16:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/9bb5b744630ae41fe9e5d9c9cc7f8e14.jpe","description":"À la fin du premier millénaire, les guerriers les plus forts et les plus cruels de leur temps se sont répandus à travers le monde entier : les Vikings. Thorfinn, le fils de l’homme réputé comme étant le plus fort des guerriers, décide de passer sa vie sur les champs de batailles malgré son jeune âge tout en rêvant d’atteindre le légendaire continent que l’on appelle « Vinland ». Dans le tourbillon d’une époque troublée, la saga d’un vrai guerrier commence.","hashes":["vinland-saga"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"CRUN-887058-VOSTFR","releaseDate":"2023-02-20T16:30:00Z","season":2,"number":7,"title":"Ketil au poing de fer","url":"https://www.crunchyroll.com/fr/vinland-saga/episode-7-iron-fist-ketil-887058","image":"https://img1.ak.crunchyroll.com/i/spire3-tmb/3d990d7343977a8f2e9773c5f53fe7d91676907163_full.jpg","duration":1555,"platform":{"uuid":"eb438d41-2152-4b4d-851b-cbb2c50201f4","name":"Crunchyroll","url":"https://www.crunchyroll.com/","image":"https://jais.ziedelth.fr/attachments/platforms/crunchyroll.jpg"}},{"uuid":"3dd5ef39-2f3e-4613-a417-c003e1c8d4f1","anime":{"uuid":"820370d1-7e48-4581-ad9f-ffc9011c871f","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"The Vampire Dies in No Time","releaseDate":"2023-01-09T15:00:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/b18b8f3b48f5892fb6e4486ff963637d.jpe","description":"Sus à l’ennemi ! Quand Ronald, chasseur de vampires, apprend qu’un enfant a été kidnappé, il se rend sur-le-champ au château de l’invincible Draluc. Loin du seigneur maléfique tel qu’il se l’était imaginé, le jeune homme découvre une mauviette qui tombe en poussière au moindre choc. Au grand dam de Ronald, il se retrouve à former une équipe malheureuse avec Draluc, la lie des vampires, et son fidèle John, tatou de compagnie. Entre personnages hauts en couleur et morts intempestives, l’aventure s’annonce rocambolesque !","hashes":["the-vampire-dies-in-no-time"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"CRUN-887045-VOSTFR","releaseDate":"2023-02-20T15:00:00Z","season":2,"number":7,"title":"Hypnozizi","url":"https://www.crunchyroll.com/fr/the-vampire-dies-in-no-time/episode-7-put-a-sock-in-it-887045","image":"https://img1.ak.crunchyroll.com/i/spire3-tmb/60de3160ba2f38181fb538d50518decc1676898688_full.jpg","duration":1420,"platform":{"uuid":"eb438d41-2152-4b4d-851b-cbb2c50201f4","name":"Crunchyroll","url":"https://www.crunchyroll.com/","image":"https://jais.ziedelth.fr/attachments/platforms/crunchyroll.jpg"}},{"uuid":"654c757a-f98b-45fd-b846-9c7911b25738","anime":{"uuid":"ec71715e-083c-41fb-9845-5becd01d28ac","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"High Card","releaseDate":"2023-01-09T12:00:00Z","image":"https://image.animationdigitalnetwork.fr/license/highcard/tv/web/affiche_350x500.jpg","description":"Nation insulaire située dans l’Atlantique Nord, le royaume de Fourland a confié au gouvernement la mission d’assurer la protection d’un trésor national : cinquante-deux cartes qui octroient à chaque détenteur un pouvoir unique, l’élevant ainsi au rang de « joueur ». Mais l’ensemble de ce jeu se retrouve dispersé, ce qui trouble l’ordre établi, attisant la convoitise de bon nombre de personnes. Pinochle, l’une des plus grandes entreprises du pays, est mandatée afin de retrouver l’ensemble des cartes « X ». Justice, désir, vengeance : la bataille ne fait que commencer…","hashes":["high-card"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"ANIM-22203-VOSTFR","releaseDate":"2023-02-20T12:00:00Z","season":1,"number":7,"title":"Love \u0026 Fake","url":"https://animationdigitalnetwork.fr/video/high-card/22203-episode-7-love-fake","image":"https://image.animationdigitalnetwork.fr/license/highcard/tv/web/eps7_640x360.jpg","duration":1420,"platform":{"uuid":"aab7ec1a-f2f5-4edc-b9a5-5eb025e228c3","name":"Animation Digital Network","url":"https://animationdigitalnetwork.fr/","image":"https://jais.ziedelth.fr/attachments/platforms/animation_digital_network.jpg"}}]',
      );

  nock('https://${Const.serverUrl}').get('/simulcasts/country/fr').reply(
        200,
        '[{"uuid":"c0f034b3-8eaa-490b-8326-e7aec8f548d8","season":"AUTUMN","year":2022},{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]',
      );

  nock('https://${Const.serverUrl}')
      .get(
        '/animes/country/fr/simulcast/4de5f48d-57e9-4a71-940c-f47ee73a9714/page/1/limit/24',
      )
      .reply(
        200,
        '[{"uuid":"d5de4edf-8fed-411b-8197-2706a3bb984a","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Arrête de me chauffer, Nagatoro","releaseDate":"2023-01-07T18:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/3b77b95ad923e19f543faa570e55d80d.jpe","description":"Alors qu’il se rend à la bibliothèque, Naoto devient un jour la cible d’une fille plus jeune que lui. Cette élève qui le taquine, l’aguiche et le tourmente s’appelle Nagatoro ! À la fois ennuyeuse, mais adorable, elle ne cesse de s’en prendre à Naoto. Mais où veut-elle en venir, finalement ? Et si ses caprices agacent le garçon, ils pourraient bien l’aider à sortir de sa timidité...","hashes":["arrête-de-me-chauffer-nagatoro"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"0dc907f1-23c5-4904-a4c4-02e49681a669","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Ayakashi Triangle","releaseDate":"2023-01-09T18:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/c1d409931b8123d72d53d86324e1ab3a.jpe","description":"Matsuri Kazamaki est un ninja qui exorcise les mauvais esprits appelés ayakashi. Comme son amie d\'enfance, Suzu Kanade, a tendance à attirer l’attention de ces monstres, il la protège en secret. Mais Suzu s’est attachée à Shirogane, un drôle de chat à l’apparence sympathique, mais qui n’est autre que le roi de tous les ayakashi…","hashes":["ayakashi-triangle"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"04271946-1497-4154-bf9b-c4e0b10822d9","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Beast Tamer","releaseDate":"2022-10-01T13:30:00Z","image":"https://img1.ak.crunchyroll.com/i/spire1/b4138b3c9fba891faea444457f484e921664617959_full.jpg","description":"Rein est un “Beast Tamer”, un dompteur de bêtes qui se bat aux côtés d’un héros et de son groupe pour abattre le Roi Démon. Mais un jour, ses camarades le déclarent inutile et le virent du groupe. Il décide alors de suivre son propre chemin. Il croise la route d’une Servale, Kanade, la plus puissante de la tribu des hommes-chats. Après avoir risqué sa vie pour la sauver, Rein passe un contrat avec elle et tous les deux entament une nouvelle vie d\'aventuriers. Mais d’autres personnes remarquent leurs pouvoirs…","hashes":["beast-tamer"],"genres":[],"simulcasts":[{"uuid":"c0f034b3-8eaa-490b-8326-e7aec8f548d8","season":"AUTUMN","year":2022},{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"5e7d0264-399e-44d5-b053-7bfe8fe1ca90","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Blue Lock","releaseDate":"2022-10-08T18:00:00Z","image":"https://img1.ak.crunchyroll.com/i/spire3/8b6ba7a861f9f9589716687d4234fae91665244129_full.jpg","description":"Après une défaite désastreuse à la Coupe du monde 2018, l\'équipe de foot du Japon peine à se ressaisir. Que leur a-t-il manqué ? Peut-être un attaquant hors pair pouvant les guider vers la victoire. L\'union japonaise de football s\'acharne à trouver quelqu’un ayant faim de buts et soif de victoire, une personne à l’individualisme assumé capable de faire basculer un match qui a mal démarré. Pour cela, elle a rassemblé 300 des plus brillants jeunes joueurs du Japon. Qui émergera pour diriger l\'équipe ? Sera-t-il capable de surpasser en force et en caractère tous ceux qui se dressent sur son chemin ?","hashes":["blue-lock"],"genres":[],"simulcasts":[{"uuid":"c0f034b3-8eaa-490b-8326-e7aec8f548d8","season":"AUTUMN","year":2022},{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"b79a7f1d-166f-487d-ac33-eef6d94d3bd8","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"BOFURI: Je suis pas venue ici pour souffrir alors j\'ai tout mis en défense.","releaseDate":"2023-01-11T16:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/c2a9f8b8f6ace62ca68d8fc6f5120c3a.jpe","description":"Un nouveau gros joueur est apparu sur le fameux VRMMO NewWorld Online ! Aucune attaque ne peut l’atteindre, et grâce à son talent de poison létal, les monstres comme les autres joueurs se font tous démolir ! Qui se cache derrière ce personnage qui, de par son style de combat original, se fait surnommer « la forteresse vivante » ou encore « le boss final » ? Une jeune fille débutante ! Maple commence à peine le jeu, sur les conseils de son amie Sally. N’y connaissant pas grand-chose, elle a mis tous ses premiers points de compétence en VIT (défense).","hashes":["bofuri-je-suis-pas-venue-ici-pour-souffrir-alors-jai-tout-mis-en-défense"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"5396d2a0-3f08-48a1-8334-e22c2d18cca1","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Boruto","releaseDate":"2022-10-02T08:30:00Z","image":"https://image.animationdigitalnetwork.fr/license/boruto/tv/web/affiche_350x500.jpg","description":"Les grands affrontements dans le monde des ninjas appartiennent désormais au passé. Le village de Konoha est entré dans une ère de paix. Boruto, le fils du 7e Hokage, vit mal d’être dans l’ombre de son éminent paternel. Il ne se doute pas qu’une nouvelle menace plane sur eux. La légende de la nouvelle génération commence maintenant !","hashes":["boruto","boruto-naruto-next-generations"],"genres":[],"simulcasts":[{"uuid":"c0f034b3-8eaa-490b-8326-e7aec8f548d8","season":"AUTUMN","year":2022},{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"e7cdc19a-7816-47a9-abe7-fa18427adc94","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Buddy Daddies","releaseDate":"2023-01-06T17:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/057908db709dec0de317006c86c0363e.jpe","description":"Deux tueurs à gages professionnels se préparent pour leur plus grosse mission : s\'occuper d\'une petite fille de cinq ans ! Comment concilier criminalité et innocence ? Cette drôle de famille temporaire parviendra-t-elle à trouver le bonheur ?","hashes":["buddy-daddies"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"45f52d3a-d848-4def-b6a6-fa15ab788e64","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Bungo Stray Dogs","releaseDate":"2023-01-04T15:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/bc9cb586a8d08ad7631f61058bd9e56f.jpe","description":"Un groupe de détectives dotés de pouvoirs paranormaux mène des enquêtes souvent dangereuses dans le plus grand secret, là où la police et l’armée refusent d’intervenir. Atsushi Nakajima a été chassé de son orphelinat. Sans-le-sou, il croise la route de ces étranges détectives tandis qu’ils pourchassent un tigre mangeur d’hommes terrorisant la population…","hashes":["bungo-stray-dogs"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"5872e56a-81ea-496c-8183-5a87a6f6c39c","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"By the Grace of the Gods","releaseDate":"2023-01-08T14:00:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/bce9f5a42210b0f65944f2b3583f3d3e.jpe","description":"Takebayashi Ryôma, un ingénieur système célibataire de 39 ans exploité par son entreprise connaît une fin des plus saugrenues dans son petit appartement. Il se retrouve invité dans un autre monde par le dieu créateur, la déesse de l’amour et le dieu de la vie pour leur venir en aide, et le voilà réincarné en petit garçon dans un autre monde ! Ryôma, désormais âgé de 8 ans, vit paisiblement au cœur de la forêt et profite de sa nouvelle vie en se consacrant à l’étude des slimes apprivoisés grâce à sa magie. Voici l’histoire de son quotidien insouciant et amusant dans un nouveau monde entouré de bonnes personnes !","hashes":["by-the-grace-of-the-gods"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"c4fdb033-ba4a-4349-99c2-9425e6725837","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"CARDFIGHT!! VANGUARD overDress","releaseDate":"2023-01-13T23:40:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/45f6d1eb2fe868c405d4e6e246191d45.jpe","description":"Yûyu Kondô, élève en troisième année de collège, est capable de lire dans le cœur des autres. Mais ceux qui connaissent son don, notamment sa famille, ont tendance à profiter de lui. Cherchant à fuir cet environnement, Yûyu fait un jour la connaissance de Megumi. Elle l’entraîne dans un endroit où se réunissent des joueurs Vanguard, notamment le groupe Team Blackout. L’adolescent est alors fasciné par ce jeu de cartes et la manière dont chaque équipe défend ses couleurs. Il se laisse convaincre de rejoindre ces nouveaux camarades...","hashes":["cardfight-vanguard-overdress"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"0bc63671-d168-414d-9656-1391d52f0f37","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Chainsaw Man","releaseDate":"2022-10-11T16:00:00Z","image":"https://img1.ak.crunchyroll.com/i/spire3/8d472eaf09dd655666b375be37d889371665498818_full.jpg","description":"Denji est un adolescent qui vit avec son chien-démon-tronçonneuse, Pochita. À cause d’une énorme dette que son père a laissée derrière lui, le garçon se retrouve dans la misère la plus totale, cherchant avec Pochita à rembourser l’argent en récoltant des cadavres de démons pour le compte d’une organisation. Un jour, Denji est trahi et tué. Encore conscient, il passe un contrat avec Pochita et renaît sous le nom de Chainsaw Man, un homme au cœur de démon…","hashes":["chainsaw-man"],"genres":[],"simulcasts":[{"uuid":"c0f034b3-8eaa-490b-8326-e7aec8f548d8","season":"AUTUMN","year":2022},{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"470c98d7-771a-44b7-98f9-3921bd71226c","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Chillin\' in My 30s after Getting Fired from the Demon King\'s Army","releaseDate":"2023-01-07T18:45:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/cc6b931f781a9923b13369ad115d6a08.jpe","description":"Dariel, 30 ans, soldat de l’armée du Seigneur des Démons, a été renvoyé car il n’a aucune maîtrise de la magie. Cependant, c’est un fin stratège et son intelligence l’amène à s’installer dans un petit village où il se met au service des habitants…","hashes":["chillin-in-my-30s-after-getting-fired-from-the-demon-kings-army"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"cb68dfe6-fce4-4c85-a9fd-2d88cbc5eee3","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Chouchouté par l’ange d’à côté","releaseDate":"2023-01-07T16:00:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/fc3071dbe9bdc0c1cbc9d4a087b41de8.jpe","description":"Amane est un étudiant taciturne qui ne parle à personne et certainement pas à sa jolie voisine, Mahiru, que ses amies surnomme l’ange. Mais depuis le jour où Amane a prêté son parapluie à Mahiru, cette dernière le voit autrement. Elle a même décidé de lui prouver sa reconnaissance de manière généreuse. Ainsi débute une romance douce, mais un peu contrariante, entre un garçon et sa voisine.","hashes":["chouchouté-par-lange-dà-côté"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"a4013951-a833-4c52-895e-2962b93c83bd","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"D4DJ All Mix","releaseDate":"2023-01-08T17:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/371789cba7d34c989e73e25d4df7dd07.jpe","description":"Miyu Sakurada, Haruna Kasuga, Miiko Takeshita et Kurumi Shiratori fréquentent l\'Académie Arisugawa. Toutes les quatre ont été saluées pour leurs efforts dans l\'unité DJ Lyrical Lily. Un jour, la Chambre de commerce leur confie une mission pour l’année à venir…","hashes":["d4dj-all-mix"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"94820685-20ec-46ab-8fee-af284d80ce0f","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"DanMachi - La Légende des Familias","releaseDate":"2023-01-05T15:00:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/36a7affbb344f61948242abeee6ec7bb.jpe","description":"Bell Cranel est le dernier descendant des membres de la famille protégée par l’impopulaire déesse Hestia. Malgré son physique peu avantageux, le jeune homme décide de partir à l’aventure dans le mystérieux Donjon de la cité-Labyrinthe d’Orario en quête de gloire et de fortune. Il y fait la connaissance de la belle Aiz Wallenstein à l’épée tranchante qui vient lui porter secours. Mais bien des dangers attendent nos deux jeunes héros.","hashes":["danmachi--la-légende-des-familias"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"5ee074fa-7ea8-4374-8788-6339eb092f01","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Digimon Ghost Game","releaseDate":"2022-10-02T02:30:00Z","image":"https://img1.ak.crunchyroll.com/i/spire1/9ea5835eb1245352a9a1121a3fe95e4a1633217257_full.jpg","description":"Dans un futur proche, la technologie a progressé. Sur les réseaux sociaux, des rumeurs se répandent sur un mystérieux phénomène autour d’un « fantôme hologramme ». Lorsque le collégien Hiro Amanokawa active un étrange objet laissé par son père, il parvient à voir de mystérieuses créatures appelées Digimon. C\'est ainsi que Hiro rencontre l\'espiègle Gammamon avec lequel il va désormais affronter des monstres effrayants qui terrorisent le monde des humains.","hashes":["digimon-ghost-game"],"genres":[],"simulcasts":[{"uuid":"c0f034b3-8eaa-490b-8326-e7aec8f548d8","season":"AUTUMN","year":2022},{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"f222dfc7-6b5a-411d-810f-f7103674d6e0","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Endô and Kobayashi Live!","releaseDate":"2023-01-06T17:55:00Z","image":"https://image.animationdigitalnetwork.fr/license/endokobayashi/tv/web/affiche_350x500.jpg","description":"Aoto Endô et Shihono Kobayashi, membre du club de radio, décident de tronquer leur ennui en jouant à un « otome game » au sein duquel évolue Liselotte, une jeune femme incomprise, vouée à un tragique destin. Au cours de leur partie, les deux amis analysent allégrement ses actions, sans se rendre compte que le prince Siegwald Fitzenhagen, son fiancé, entend leurs paroles. Pensant qu’il s’agit d’un acte providentiel, il est bien décidé à contrer le funeste sort qui attend sa bien-aimée grâce aux conseils prodigués par Endô et Kobayashi !","hashes":["endô-and-kobayashi-live"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"86b274a7-852c-4c4c-9f6f-cb97eab6d27f","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Eternal Boys","releaseDate":"2022-10-24T17:00:00Z","image":"https://image.animationdigitalnetwork.fr/license/eternalboys/tv/web/affiche_350x500.jpg","description":"Bien que rien ne semble les lier, six hommes ayant connu des échecs successifs dans leur vie personnelle et professionnelle décident de se lancer un nouveau défi : montrer qu’ils sont capables, en dépit de leur âge, d’atteindre les sommets de la gloire et de la célébrité. Ensemble, ils forment les « Eternal Boys », un groupe d’idols de quadragénaires.","hashes":["eternal-boys"],"genres":[],"simulcasts":[{"uuid":"c0f034b3-8eaa-490b-8326-e7aec8f548d8","season":"AUTUMN","year":2022},{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"b1225585-4a02-4dd4-b8ec-b4d6eb9eeac6","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Farming Life in Another World","releaseDate":"2023-01-06T13:00:00Z","image":"https://image.animationdigitalnetwork.fr/license/farminganotherworld/tv/web/affiche_350x500.jpg","description":"Alors qu’il tente de sauver de la faillite l’entreprise dans laquelle il travaille, Hiruka Machio, 39 ans, meurt de surmenage. À sa demande, une divinité lui offre l’opportunité de renaître dans un autre monde, sous les traits d’un jeune fermier, lui octroyant également un outil agricole surpuissant. Dès lors, Hiruka se donne corps et âme dans sa nouvelle activité, si bien que les denrées qu’il produit sont d’une qualité incomparable. Mais ces dernières finissent par susciter l’avidité des monstres attenants…","hashes":["farming-life-in-another-world"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"5f277ac1-e335-49d0-b4f5-732b3a23ffc6","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Giant Beasts of Ars","releaseDate":"2023-01-06T16:55:00Z","image":"https://image.animationdigitalnetwork.fr/license/giantbeastsofars/tv/web/affiche_350x500.jpg","description":"Dans un monde ravagé par le fléau des « bêtes géantes », les humains traquent ces dernières et utilisent les ressources qu’elles génèrent afin de prospérer. Jiiro, un chasseur surnommé « l’immortel », tente de survivre dans cet univers impitoyable. Mais un jour, il croise le chemin de Kuumi, une jeune femme s’étant enfuie d’un laboratoire secret, dont l’existence-même pourrait bouleverser l’équilibre de la société établie par les Hommes…","hashes":["giant-beasts-of-ars"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"f0949c72-0009-4853-b7b4-61272712c534","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Handyman Saitou in another world","releaseDate":"2023-01-08T15:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/35ac1d958688dce29fba1cc21344ec5f.jpe","description":"Handyman Saitô n\'a jamais été quelqu\'un de spécial. Toute sa vie, il a eu des notes moyennes, des performances sportives ordinaires, un travail banal... Mais sa vie bascule lorsqu\'il se réveille dans un autre monde. Là-bas, des guerriers, des sorciers et des elfes l\'accompagnent dans des quêtes au cœur des donjons et Saitô caresse pour la première fois le sentiment de se sentir indispensable. Après tout, qui d\'autre que cet homme à tout faire pourrait ouvrir des coffres à trésors verrouillés ou saurait réparer l\'équipement de ses alliés ?","hashes":["handyman-saitou-in-another-world"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"1b2056fe-c4d8-49c1-a18e-99cfd1a0cd67","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Hero Skill - Achats en ligne","releaseDate":"2023-01-10T17:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/14e2a9a065ac003f19a1d06b601aeb87.jpe","description":"Tsuyoshi Mukoda, un salarié ordinaire, est un jour soudainement transporté dans un autre monde. À son arrivée, la compétence unique (et apparemment inutile) qu\'il acquiert est le supermarché en ligne. Découragé au début, le jeune homme finit par comprendre que les aliments modernes qu\'il est capable d\'apporter dans ce monde, grâce à cette compétence, s\'avèrent avoir des effets incroyables !","hashes":["hero-skill--achats-en-ligne"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"ec71715e-083c-41fb-9845-5becd01d28ac","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"High Card","releaseDate":"2023-01-09T12:00:00Z","image":"https://image.animationdigitalnetwork.fr/license/highcard/tv/web/affiche_350x500.jpg","description":"Nation insulaire située dans l’Atlantique Nord, le royaume de Fourland a confié au gouvernement la mission d’assurer la protection d’un trésor national : cinquante-deux cartes qui octroient à chaque détenteur un pouvoir unique, l’élevant ainsi au rang de « joueur ». Mais l’ensemble de ce jeu se retrouve dispersé, ce qui trouble l’ordre établi, attisant la convoitise de bon nombre de personnes. Pinochle, l’une des plus grandes entreprises du pays, est mandatée afin de retrouver l’ensemble des cartes « X ». Justice, désir, vengeance : la bataille ne fait que commencer…","hashes":["high-card"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},{"uuid":"6bc76949-c4e9-4a58-8cec-bf51e83be112","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"In/Spectre","releaseDate":"2023-01-08T16:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/f219f23136942b2aca33fdb3f9449703.jpe","description":"Dans son enfance, Kotoko a été enlevée par des esprits pour devenir la « déesse de la sagesse ». Ces créatures surnaturelles l\'ont transformée en un intermédiaire puissant entre le monde des esprits et celui des humains, mais ce pouvoir a eu un prix : un œil et une jambe ! Un jour, elle rencontre Kurô, un jeune homme au cœur brisé, qui semble avoir un étrange effet sur les esprits : ils sont terrifiés à sa simple vue ! Quel est le secret du jeune homme ? Va-t-il pouvoir prêter main-forte à Kotoko face aux esprits maléfiques et l’aider à préserver le monde des humains ?","hashes":["inspectre"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]}]',
      );

  nock('https://${Const.serverUrl}').get('/episodetypes').reply(
        200,
        '[{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},{"uuid":"c92857d7-1dc2-4d3e-87f6-82c60c1e43e9","name":"SPECIAL"},{"uuid":"97923628-8735-4d93-8fb6-258e6447bfba","name":"FILM"}]',
      );

  nock('https://${Const.serverUrl}').get('/langtypes').reply(
        200,
        '[{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},{"uuid":"7c40ea6a-baac-4875-836e-066b0b8b5bf8","name":"VOICE"}]',
      );

  nock('https://${Const.serverUrl}')
      .post('/episodes/watchlist_filter/page/1/limit/12', anything)
      .reply(200, '[]');

  nock('https://${Const.serverUrl}')
      .get('/animes/country/fr/search/name/Boruto')
      .reply(
        200,
        '[{"uuid":"5396d2a0-3f08-48a1-8334-e22c2d18cca1","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Boruto","releaseDate":"2022-10-02T08:30:00Z","image":"https://image.animationdigitalnetwork.fr/license/boruto/tv/web/affiche_350x500.jpg","description":"Les grands affrontements dans le monde des ninjas appartiennent désormais au passé. Le village de Konoha est entré dans une ère de paix. Boruto, le fils du 7e Hokage, vit mal d’être dans l’ombre de son éminent paternel. Il ne se doute pas qu’une nouvelle menace plane sur eux… La légende de la nouvelle génération commence maintenant !","hashes":["boruto","boruto-naruto-next-generations"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023},{"uuid":"c0f034b3-8eaa-490b-8326-e7aec8f548d8","season":"AUTUMN","year":2022}]}]',
      );

  nock('https://${Const.serverUrl}')
      .get(
        '/episodes/anime/d5de4edf-8fed-411b-8197-2706a3bb984a/page/1/limit/12',
      )
      .reply(
        200,
        '[{"uuid":"900efa82-f99b-453d-bf49-3b98f152d983","anime":{"uuid":"d5de4edf-8fed-411b-8197-2706a3bb984a","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Arrête de me chauffer, Nagatoro","releaseDate":"2023-01-07T18:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/3b77b95ad923e19f543faa570e55d80d.jpe","description":"Alors qu’il se rend à la bibliothèque, Naoto devient un jour la cible d’une fille plus jeune que lui. Cette élève qui le taquine, l’aguiche et le tourmente s’appelle Nagatoro ! À la fois ennuyeuse, mais adorable, elle ne cesse de s’en prendre à Naoto. Mais où veut-elle en venir, finalement ? Et si ses caprices agacent le garçon, ils pourraient bien l’aider à sortir de sa timidité...","hashes":["arrête-de-me-chauffer-nagatoro"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"CRUN-887715-VOSTFR","releaseDate":"2023-02-18T18:30:00Z","season":2,"number":8,"title":"Et si tu faisais un peu de muscu ?","url":"https://www.crunchyroll.com/fr/dont-toy-with-me-miss-nagatoro/episode-8-why-dont-you-try-bulking-up-a-little-paisen-887715","image":"https://img1.ak.crunchyroll.com/i/spire3-tmb/e90e2a0caba3e3f16427c83e4ae719e41676741110_full.jpg","duration":1420,"platform":{"uuid":"eb438d41-2152-4b4d-851b-cbb2c50201f4","name":"Crunchyroll","url":"https://www.crunchyroll.com/","image":"https://jais.ziedelth.fr/attachments/platforms/crunchyroll.jpg"}},{"uuid":"a0a78996-f469-4848-af2e-f3711d8644c5","anime":{"uuid":"d5de4edf-8fed-411b-8197-2706a3bb984a","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Arrête de me chauffer, Nagatoro","releaseDate":"2023-01-07T18:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/3b77b95ad923e19f543faa570e55d80d.jpe","description":"Alors qu’il se rend à la bibliothèque, Naoto devient un jour la cible d’une fille plus jeune que lui. Cette élève qui le taquine, l’aguiche et le tourmente s’appelle Nagatoro ! À la fois ennuyeuse, mais adorable, elle ne cesse de s’en prendre à Naoto. Mais où veut-elle en venir, finalement ? Et si ses caprices agacent le garçon, ils pourraient bien l’aider à sortir de sa timidité...","hashes":["arrête-de-me-chauffer-nagatoro"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"CRUN-887714-VOSTFR","releaseDate":"2023-02-11T18:30:00Z","season":2,"number":7,"title":"Ça m\u0027étonne pas que tu sois nul","url":"https://www.crunchyroll.com/fr/dont-toy-with-me-miss-nagatoro/episode-7-i-figured-thats-how-youd-ski-senpai-887714","image":"https://img1.ak.crunchyroll.com/i/spire2-tmb/11422c89240b1ca5a9452d0328fca9ff1676140271_full.jpg","duration":1420,"platform":{"uuid":"eb438d41-2152-4b4d-851b-cbb2c50201f4","name":"Crunchyroll","url":"https://www.crunchyroll.com/","image":"https://jais.ziedelth.fr/attachments/platforms/crunchyroll.jpg"}},{"uuid":"b7eb075d-1d52-4823-a23a-faa282db7155","anime":{"uuid":"d5de4edf-8fed-411b-8197-2706a3bb984a","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Arrête de me chauffer, Nagatoro","releaseDate":"2023-01-07T18:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/3b77b95ad923e19f543faa570e55d80d.jpe","description":"Alors qu’il se rend à la bibliothèque, Naoto devient un jour la cible d’une fille plus jeune que lui. Cette élève qui le taquine, l’aguiche et le tourmente s’appelle Nagatoro ! À la fois ennuyeuse, mais adorable, elle ne cesse de s’en prendre à Naoto. Mais où veut-elle en venir, finalement ? Et si ses caprices agacent le garçon, ils pourraient bien l’aider à sortir de sa timidité...","hashes":["arrête-de-me-chauffer-nagatoro"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"CRUN-887713-VOSTFR","releaseDate":"2023-02-04T18:30:00Z","season":2,"number":6,"title":"Seras-tu chanceux cette année ?","url":"https://www.crunchyroll.com/fr/dont-toy-with-me-miss-nagatoro/episode-6-how-are-your-fortunes-this-year-senpai-887713","image":"https://img1.ak.crunchyroll.com/i/spire4-tmb/93f6f509979f948235e724a7d98de9aa1675529512_full.jpg","duration":1420,"platform":{"uuid":"eb438d41-2152-4b4d-851b-cbb2c50201f4","name":"Crunchyroll","url":"https://www.crunchyroll.com/","image":"https://jais.ziedelth.fr/attachments/platforms/crunchyroll.jpg"}},{"uuid":"17cfd962-4032-4cec-9728-87484151ba54","anime":{"uuid":"d5de4edf-8fed-411b-8197-2706a3bb984a","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Arrête de me chauffer, Nagatoro","releaseDate":"2023-01-07T18:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/3b77b95ad923e19f543faa570e55d80d.jpe","description":"Alors qu’il se rend à la bibliothèque, Naoto devient un jour la cible d’une fille plus jeune que lui. Cette élève qui le taquine, l’aguiche et le tourmente s’appelle Nagatoro ! À la fois ennuyeuse, mais adorable, elle ne cesse de s’en prendre à Naoto. Mais où veut-elle en venir, finalement ? Et si ses caprices agacent le garçon, ils pourraient bien l’aider à sortir de sa timidité...","hashes":["arrête-de-me-chauffer-nagatoro"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"CRUN-887712-VOSTFR","releaseDate":"2023-01-28T18:30:00Z","season":2,"number":5,"title":"C\u0027est à ça que ressemble ta chambre","url":"https://www.crunchyroll.com/fr/dont-toy-with-me-miss-nagatoro/episode-5-so-this-is-your-room-huh-senpai-887712","image":"https://img1.ak.crunchyroll.com/i/spire3-tmb/25c9bb1ca8a226791b4da265b202911c1674922020_full.jpg","duration":1420,"platform":{"uuid":"eb438d41-2152-4b4d-851b-cbb2c50201f4","name":"Crunchyroll","url":"https://www.crunchyroll.com/","image":"https://jais.ziedelth.fr/attachments/platforms/crunchyroll.jpg"}},{"uuid":"d49bcf39-0ece-4729-9c48-6354f0ae2e1c","anime":{"uuid":"d5de4edf-8fed-411b-8197-2706a3bb984a","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Arrête de me chauffer, Nagatoro","releaseDate":"2023-01-07T18:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/3b77b95ad923e19f543faa570e55d80d.jpe","description":"Alors qu’il se rend à la bibliothèque, Naoto devient un jour la cible d’une fille plus jeune que lui. Cette élève qui le taquine, l’aguiche et le tourmente s’appelle Nagatoro ! À la fois ennuyeuse, mais adorable, elle ne cesse de s’en prendre à Naoto. Mais où veut-elle en venir, finalement ? Et si ses caprices agacent le garçon, ils pourraient bien l’aider à sortir de sa timidité...","hashes":["arrête-de-me-chauffer-nagatoro"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"CRUN-887711-VOSTFR","releaseDate":"2023-01-21T18:30:00Z","season":2,"number":4,"title":"Tu peux entrer. Fais comme chez toi.","url":"https://www.crunchyroll.com/fr/dont-toy-with-me-miss-nagatoro/episode-4-why-dont-you-come-inside-senpai-kun-887711","image":"https://img1.ak.crunchyroll.com/i/spire2-tmb/ce59684e86d8f1fbd5fa0484002c63531674289880_full.jpg","duration":1420,"platform":{"uuid":"eb438d41-2152-4b4d-851b-cbb2c50201f4","name":"Crunchyroll","url":"https://www.crunchyroll.com/","image":"https://jais.ziedelth.fr/attachments/platforms/crunchyroll.jpg"}},{"uuid":"43339531-4c64-4428-bed3-e8252f549f19","anime":{"uuid":"d5de4edf-8fed-411b-8197-2706a3bb984a","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Arrête de me chauffer, Nagatoro","releaseDate":"2023-01-07T18:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/3b77b95ad923e19f543faa570e55d80d.jpe","description":"Alors qu’il se rend à la bibliothèque, Naoto devient un jour la cible d’une fille plus jeune que lui. Cette élève qui le taquine, l’aguiche et le tourmente s’appelle Nagatoro ! À la fois ennuyeuse, mais adorable, elle ne cesse de s’en prendre à Naoto. Mais où veut-elle en venir, finalement ? Et si ses caprices agacent le garçon, ils pourraient bien l’aider à sortir de sa timidité...","hashes":["arrête-de-me-chauffer-nagatoro"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"CRUN-887710-VOSTFR","releaseDate":"2023-01-14T18:30:00Z","season":2,"number":3,"title":"T\u0027as entendu notre conversation ?","url":"https://www.crunchyroll.com/fr/dont-toy-with-me-miss-nagatoro/episode-3-senpai-were-you-listening-to-what-i-said-887710","image":"https://img1.ak.crunchyroll.com/i/spire1-tmb/a9b4d753b0eb1479acf9f79b5efd5da11673718439_full.jpg","duration":1420,"platform":{"uuid":"eb438d41-2152-4b4d-851b-cbb2c50201f4","name":"Crunchyroll","url":"https://www.crunchyroll.com/","image":"https://jais.ziedelth.fr/attachments/platforms/crunchyroll.jpg"}},{"uuid":"ccdb4f73-6ee0-44df-beb9-a10166181b08","anime":{"uuid":"d5de4edf-8fed-411b-8197-2706a3bb984a","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Arrête de me chauffer, Nagatoro","releaseDate":"2023-01-07T18:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/3b77b95ad923e19f543faa570e55d80d.jpe","description":"Alors qu’il se rend à la bibliothèque, Naoto devient un jour la cible d’une fille plus jeune que lui. Cette élève qui le taquine, l’aguiche et le tourmente s’appelle Nagatoro ! À la fois ennuyeuse, mais adorable, elle ne cesse de s’en prendre à Naoto. Mais où veut-elle en venir, finalement ? Et si ses caprices agacent le garçon, ils pourraient bien l’aider à sortir de sa timidité...","hashes":["arrête-de-me-chauffer-nagatoro"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"CRUN-886709-VOSTFR","releaseDate":"2023-01-11T08:00:00Z","season":2,"number":2,"title":"Ça alors, tu m\u0027invites ?","url":"https://www.crunchyroll.com/fr/dont-toy-with-me-miss-nagatoro/episode-2-youre-inviting-me-senpai-886709","image":"https://img1.ak.crunchyroll.com/i/spire2-tmb/794627c3f098b425e22a9f207ffc1fcb1673417388_full.jpg","duration":1419,"platform":{"uuid":"eb438d41-2152-4b4d-851b-cbb2c50201f4","name":"Crunchyroll","url":"https://www.crunchyroll.com/","image":"https://jais.ziedelth.fr/attachments/platforms/crunchyroll.jpg"}},{"uuid":"85f312d3-a9a5-42ef-85ee-a774b1a5243e","anime":{"uuid":"d5de4edf-8fed-411b-8197-2706a3bb984a","country":{"uuid":"a6029576-0071-41b8-a2eb-01b007d1d96c","tag":"fr","name":"France"},"name":"Arrête de me chauffer, Nagatoro","releaseDate":"2023-01-07T18:30:00Z","image":"https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/3b77b95ad923e19f543faa570e55d80d.jpe","description":"Alors qu’il se rend à la bibliothèque, Naoto devient un jour la cible d’une fille plus jeune que lui. Cette élève qui le taquine, l’aguiche et le tourmente s’appelle Nagatoro ! À la fois ennuyeuse, mais adorable, elle ne cesse de s’en prendre à Naoto. Mais où veut-elle en venir, finalement ? Et si ses caprices agacent le garçon, ils pourraient bien l’aider à sortir de sa timidité...","hashes":["arrête-de-me-chauffer-nagatoro"],"genres":[],"simulcasts":[{"uuid":"4de5f48d-57e9-4a71-940c-f47ee73a9714","season":"WINTER","year":2023}]},"episodeType":{"uuid":"8e8a9047-0901-4e53-a81c-fb7a462ca202","name":"EPISODE"},"langType":{"uuid":"5164e91f-10a5-4f01-a984-05c3d4b95b70","name":"SUBTITLES"},"hash":"CRUN-886708-VOSTFR","releaseDate":"2023-01-07T18:30:00Z","season":2,"number":1,"title":"On est potes, non ?","url":"https://www.crunchyroll.com/fr/dont-toy-with-me-miss-nagatoro/episode-1-its-you-and-me-senpai-886708","image":"https://img1.ak.crunchyroll.com/i/spire2-tmb/6debe0de8233557d5816d395a1e042fa1673098737_full.jpg","duration":1420,"platform":{"uuid":"eb438d41-2152-4b4d-851b-cbb2c50201f4","name":"Crunchyroll","url":"https://www.crunchyroll.com/","image":"https://jais.ziedelth.fr/attachments/platforms/crunchyroll.jpg"}}]',
      );
}

Future<void> testEpisodeTab(WidgetTester widgetTester, int atLeast) async {
  expect(find.byType(TopNavigationBar), findsOneWidget);
  expect(find.byType(EpisodeList), findsOneWidget);
  expect(find.byType(EpisodeLoaderWidget), findsAtLeastNWidgets(atLeast));
  expect(find.byType(BottomNavigationBar), findsOneWidget);
  await widgetTester.pump();
  expect(find.byType(TopNavigationBar), findsOneWidget);
  expect(find.byType(EpisodeList), findsOneWidget);
  expect(find.byType(EpisodeWidget), findsAtLeastNWidgets(atLeast));
  expect(find.byType(BottomNavigationBar), findsOneWidget);
}

Future<void> testWatchlistTab(WidgetTester widgetTester, int atLeast) async {
  expect(find.byType(TopNavigationBar), findsOneWidget);
  expect(find.byType(EpisodeList), findsOneWidget);
  expect(find.byType(EpisodeLoaderWidget), findsAtLeastNWidgets(atLeast));
  expect(find.byType(BottomNavigationBar), findsOneWidget);
  await widgetTester.pump();
  expect(find.byType(TopNavigationBar), findsOneWidget);
  expect(find.byType(NoElement), findsOneWidget);
  expect(find.byType(BottomNavigationBar), findsOneWidget);
}

Future<void> testAnimeTab(
  WidgetTester widgetTester,
  int atLeastSimulcast,
  int atLeastAnime,
) async {
  expect(find.byType(TopNavigationBar), findsOneWidget);
  expect(find.byType(SimulcastList), findsOneWidget);
  expect(
    find.byType(SimulcastLoaderWidget),
    findsAtLeastNWidgets(atLeastSimulcast),
  );
  expect(find.byType(AnimeList), findsOneWidget);
  expect(find.byType(AnimeLoaderWidget), findsAtLeastNWidgets(atLeastAnime));
  expect(find.byType(BottomNavigationBar), findsOneWidget);
  await widgetTester.pump();
  expect(find.byType(TopNavigationBar), findsOneWidget);
  expect(find.byType(SimulcastList), findsOneWidget);
  expect(find.byType(SimulcastWidget), findsAtLeastNWidgets(atLeastSimulcast));
  expect(find.byType(AnimeList), findsOneWidget);
  expect(find.byType(AnimeWidget), findsAtLeastNWidgets(atLeastAnime));
  expect(find.byType(BottomNavigationBar), findsOneWidget);
}

void main() {
  final List<Size> sizes = <Size>[
    const Size(360, 640),
    const Size(768, 1024),
    const Size(1024, 768),
    const Size(1024, 1366),
    const Size(1440, 2560),
    const Size(2560, 1440),
  ];

  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(nock.init);
  setUp(nock.cleanAll);

  group('HomeView on Android', () {
    for (final size in sizes) {
      group('${size.width.toInt()}x${size.height.toInt()}', () {
        testWidgets('Default Tabs', (widgetTester) async {
          nockUrl();

          widgetTester.binding.window.physicalSizeTestValue = size;
          widgetTester.binding.window.devicePixelRatioTestValue = 1.0;
          debugDefaultTargetPlatformOverride = TargetPlatform.android;

          info('HomeViewTest', 'Init controllers');
          SharedPreferences.setMockInitialValues({});
          await AppController.seen.init();
          await AppController.watchlist.init();
          await FilterController.instance.init();

          debug('HomeViewTest', '-' * 50);
          debug('HomeViewTest', 'Build widget');

          await widgetTester.pumpWidget(const MaterialApp(home: HomeView()));

          debugDefaultTargetPlatformOverride = null;

          // EPISODES TAB
          debug('HomeViewTest', '-' * 50);
          await testEpisodeTab(widgetTester, size.width > 768 ? 6 : 2);

          // WATCHLIST TAB
          debug('HomeViewTest', 'Tap on watchlist tab');
          await widgetTester.tap(find.byIcon(Icons.list));
          await widgetTester.pump();

          await testWatchlistTab(widgetTester, size.width > 768 ? 3 : 1);
          debug('HomeViewTest', '-' * 50);

          // ANIME TAB
          debug('HomeViewTest', 'Tap on anime tab');
          await widgetTester.tap(find.byIcon(Icons.live_tv));
          await widgetTester.pump();

          await testAnimeTab(widgetTester, 2, size.width > 768 ? 6 : 2);
          expect(find.byIcon(Icons.search), findsOneWidget);
          expect(find.byIcon(Icons.calendar_view_week), findsOneWidget);
          debug('HomeViewTest', '-' * 50);
        });

        testWidgets('Search View', (widgetTester) async {
          nockUrl();

          widgetTester.binding.window.physicalSizeTestValue = size;
          widgetTester.binding.window.devicePixelRatioTestValue = 1.0;
          debugDefaultTargetPlatformOverride = TargetPlatform.android;

          info('HomeViewTest', 'Init controllers');
          SharedPreferences.setMockInitialValues({});
          await AppController.seen.init();
          await AppController.watchlist.init();
          await FilterController.instance.init();

          debug('HomeViewTest', '-' * 50);
          debug('HomeViewTest', 'Build widget');

          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: '/',
              routes: {
                '/': (context) => const HomeView(),
                '/anime/search': (_) {
                  return AnimeSearchView(controller: AnimeSearchController());
                },
                '/anime/detail': (_) {
                  return AnimeDetailView(controller: AnimeDetailController());
                },
                '/anime/diary': (_) {
                  return AnimeDiaryView(controller: AnimeDiaryController());
                },
              },
            ),
          );

          debugDefaultTargetPlatformOverride = null;

          // EPISODES TAB
          debug('HomeViewTest', '-' * 50);
          await testEpisodeTab(widgetTester, 2);

          // WATCHLIST TAB
          debug('HomeViewTest', 'Tap on watchlist tab');
          await widgetTester.tap(find.byIcon(Icons.list));
          await widgetTester.pump();

          await testWatchlistTab(widgetTester, 1);
          debug('HomeViewTest', '-' * 50);

          // ANIME TAB
          debug('HomeViewTest', 'Tap on anime tab');
          await widgetTester.tap(find.byIcon(Icons.live_tv));
          await widgetTester.pump();

          await testAnimeTab(widgetTester, 2, 2);
          expect(find.byIcon(Icons.search), findsOneWidget);
          expect(find.byIcon(Icons.calendar_view_week), findsOneWidget);
          debug('HomeViewTest', '-' * 50);

          // SEARCH VIEW
          debug('HomeViewTest', 'Tap on search icon');
          await widgetTester.tap(find.byIcon(Icons.search));
          await widgetTester.pumpAndSettle();

          expect(find.byType(TopNavigationBar), findsNothing);
          expect(find.byType(AppBar), findsOneWidget);
          expect(find.byType(AnimeList), findsOneWidget);
          expect(find.byType(AnimeLoaderWidget), findsNothing);
          expect(find.byType(AnimeWidget), findsNothing);

          // Enter text
          debug('HomeViewTest', 'Enter text');
          await widgetTester.enterText(find.byType(TextField), 'Boruto');
          await widgetTester.testTextInput
              .receiveAction(TextInputAction.search);
          await widgetTester.pump();

          expect(find.byType(TopNavigationBar), findsNothing);
          expect(find.byType(AppBar), findsOneWidget);
          expect(find.byType(AnimeList), findsOneWidget);
          expect(find.byType(AnimeLoaderWidget), findsNothing);
          expect(find.byType(AnimeWidget), findsOneWidget);
        });

        testWidgets('Diary View', (widgetTester) async {
          nockUrl();

          widgetTester.binding.window.physicalSizeTestValue = size;
          widgetTester.binding.window.devicePixelRatioTestValue = 1.0;
          debugDefaultTargetPlatformOverride = TargetPlatform.android;

          info('HomeViewTest', 'Init controllers');
          SharedPreferences.setMockInitialValues({});
          await AppController.seen.init();
          await AppController.watchlist.init();
          await FilterController.instance.init();

          debug('HomeViewTest', '-' * 50);
          debug('HomeViewTest', 'Build widget');

          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: '/',
              routes: {
                '/': (context) => const HomeView(),
                '/anime/search': (_) {
                  return AnimeSearchView(controller: AnimeSearchController());
                },
                '/anime/detail': (_) {
                  return AnimeDetailView(controller: AnimeDetailController());
                },
                '/anime/diary': (_) {
                  return AnimeDiaryView(controller: AnimeDiaryController());
                },
              },
            ),
          );

          debugDefaultTargetPlatformOverride = null;

          // EPISODES TAB
          debug('HomeViewTest', '-' * 50);
          await testEpisodeTab(widgetTester, 2);

          // WATCHLIST TAB
          debug('HomeViewTest', 'Tap on watchlist tab');
          await widgetTester.tap(find.byIcon(Icons.list));
          await widgetTester.pump();

          await testWatchlistTab(widgetTester, 1);
          debug('HomeViewTest', '-' * 50);

          // ANIME TAB
          debug('HomeViewTest', 'Tap on anime tab');
          await widgetTester.tap(find.byIcon(Icons.live_tv));
          await widgetTester.pump();

          await testAnimeTab(widgetTester, 2, 2);
          expect(find.byIcon(Icons.search), findsOneWidget);
          expect(find.byIcon(Icons.calendar_view_week), findsOneWidget);
          debug('HomeViewTest', '-' * 50);

          // DIARY VIEW
          debug('HomeViewTest', 'Tap on diary icon');
          await widgetTester.tap(find.byIcon(Icons.calendar_view_week));
          await widgetTester.pumpAndSettle();

          expect(find.byType(TopNavigationBar), findsNothing);
          expect(find.byType(AppBar), findsOneWidget);
          expect(find.byType(AnimeList), findsOneWidget);
        });

        testWidgets('Anime Detail View', (widgetTester) async {
          nockUrl();

          widgetTester.binding.window.physicalSizeTestValue = size;
          widgetTester.binding.window.devicePixelRatioTestValue = 1.0;
          debugDefaultTargetPlatformOverride = TargetPlatform.android;

          info('HomeViewTest', 'Init controllers');
          SharedPreferences.setMockInitialValues({});
          await AppController.seen.init();
          await AppController.watchlist.init();
          await FilterController.instance.init();

          debug('HomeViewTest', '-' * 50);
          debug('HomeViewTest', 'Build widget');

          await widgetTester.pumpWidget(
            MaterialApp(
              initialRoute: '/',
              routes: {
                '/': (context) => const HomeView(),
                '/anime/search': (_) {
                  return AnimeSearchView(controller: AnimeSearchController());
                },
                '/anime/detail': (_) {
                  return AnimeDetailView(controller: AnimeDetailController());
                },
                '/anime/diary': (_) {
                  return AnimeDiaryView(controller: AnimeDiaryController());
                },
              },
            ),
          );

          debugDefaultTargetPlatformOverride = null;

          // EPISODES TAB
          debug('HomeViewTest', '-' * 50);
          await testEpisodeTab(widgetTester, 2);

          // WATCHLIST TAB
          debug('HomeViewTest', 'Tap on watchlist tab');
          await widgetTester.tap(find.byIcon(Icons.list));
          await widgetTester.pump();

          await testWatchlistTab(widgetTester, 1);
          debug('HomeViewTest', '-' * 50);

          // ANIME TAB
          debug('HomeViewTest', 'Tap on anime tab');
          await widgetTester.tap(find.byIcon(Icons.live_tv));
          await widgetTester.pump();

          await testAnimeTab(widgetTester, 2, 2);
          expect(find.byIcon(Icons.search), findsOneWidget);
          expect(find.byIcon(Icons.calendar_view_week), findsOneWidget);
          debug('HomeViewTest', '-' * 50);

          // ANIME DETAIL VIEW
          debug('HomeViewTest', 'Tap on anime');
          await widgetTester.tap(find.byType(AnimeWidget).first);

          for (int i = 0; i < 5; i++) {
            // because pumpAndSettle doesn't work with riverpod
            await widgetTester.pump(const Duration(seconds: 1));
          }

          expect(find.byType(TopNavigationBar), findsNothing);
          expect(find.byType(AppBar), findsOneWidget);
          expect(find.byType(LiteEpisodeList), findsOneWidget);
          expect(find.byType(LiteEpisodeWidget), findsAtLeastNWidgets(1));
        });
      });
    }
  });
}
