import Foundation

class ProductsModel {
    
    func createModels() -> [[Product]] {
        return [
            [Product(
                id: 1,
                name: "Напиток Alpro миндальный без сахара",
                type: .dairy,
                description: "В составе есть вода, миндальная паста (из обжаренного миндаля (100%)), трикальций фосфат (источник кальция), соль, стабилизаторы (камедь рожкового дерева, геллановая камедь), эмульгатор (лецитины (подсолнечный)). Может содержать следы других орехов, глютена и сои. Пищевая ценность на 100 г продукта (среднее значение): жира – 1,1 г; белка - 0,4 г; углеводов - 0,1 г, кальция – 120 мг (12% от рекомендуемой суточной потребности).",
                price: 2555,
                origin: .russia,
                weight: 1,
                measure: .litre,
                imageName: "almondmilk.jpeg",
                isAvailable: false,
                chosenAmount: 0
            ),
             Product(
                 id: 2,
                 name: "Сметана Простоквашино 15%",
                 type: .dairy,
                 description: "Сметана «Простоквашино» - натуральный продукт, приготовленный по традиционным рецептам из свежих заквасок и сливок. Продукт используется как добавка к пельменям и вареникам, салатная заправка или самостоятельный соус. Хозяйки часто используют сметану в составе кондитерских кремов, а также добавляют в подливы для мясных, грибных и овощных блюд.",
                 price: 965,
                 origin: .russia,
                 weight: 300,
                 measure: .gram,
                 imageName: "sourcream.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 3,
                 name: "Молоко Foodmaster Легкое утро безлактозное 2.5%",
                 type: .dairy,
                 description: "Молоко Foodmaster произведено из молока самого высокого качества, используя современную технологию обработки ультравысокой температурой (УВТ), которая позволяет очистить молоко от бактерий и сохранить все полезные составляющие (кальций, белок, витамины и минералы).",
                 price: 1015,
                 origin: .kazakhstan,
                 weight: 1,
                 measure: .litre,
                 imageName: "regularmilk.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 4,
                 name: "Молоко Clearspring кокосовое",
                 type: .dairy,
                 description: "Это богатое и сливочное органическое кокосовое молоко получается из лучших шри-ланкийских кокосов, которые просто очищают от скорлупы, измельчают, прессуют и фильтруют. Благодаря своему умеренно сладкому вкусу, он идеально подходит для использования в восточных и индийских блюдах, таких как карри, супы и жаркое, а также в качестве молочной альтернативы в десертах и ​​выпечке.",
                 price: 7314,
                 origin: .china,
                 weight: 400,
                 measure: .gram,
                 imageName: "coconutmilk.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 5,
                 name: "Напиток Nemoloko рисовый классический лайт",
                 type: .dairy,
                 description: "Низкокалорийное (60 ккал) и без добавления сахара рисовое Nemoloko обладает высокой пищевой ценностью и сделает рацион питания более разнообразным, что особенно важно для людей, придерживающихся безглютеновой диеты. Благодаря нейтральному вкусу и отсутствию доминирующих вкусовых акцентов, этот продукт идеально подходит для приготовления сбалансированного завтрака, домашней выпечки, нежных коктейлей, а так же для добавления в кофе.",
                 price: 1145,
                 origin: .russia,
                 weight: 1,
                 measure: .litre,
                 imageName: "ricemilk.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 6,
                 name: "Масло President высший сорт 82%",
                 type: .dairy,
                 description: "Масло «Президент» обладает неповторимым сливочным вкусом, мягкой консистенцией – не крошится и прекрасно ложится на бутерброд. Высокое качество Президент подтверждено многолетним доверием потребителей.",
                 price: 1270,
                 origin: .kazakhstan,
                 weight: 180,
                 measure: .gram,
                 imageName: "butter.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 7,
                 name: "Творог Adal зернистый 5%",
                 type: .dairy,
                 description: "Творог 5% является универсальным продуктом, который одинаково хорош как самостоятельное блюдо, так и в качестве ингредиента салатов, начинок для пирогов и блинов, основы для приготовления сырника, творожных пудингов и запеканок. Творог отлично сочетается со свежими ягодами, сметаной, вареньями, мёдом, корицей или, например, с зеленью и чесноком.",
                 price: 865,
                 origin: .kazakhstan,
                 weight: 300,
                 measure: .gram,
                 imageName: "curd.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 8,
                 name: "Йогурт Чудо Персик-маракуйя густой 2%",
                 type: .dairy,
                 description: "Необычное сочетание вкусов экзотической маракуйи и сочного персика подарит истинное наслаждение для любителей смелых сочетаний! В составе есть молоко нормализованное, молоко восстановленное, сахар, персик, вода, стабилизаторы (Е1422 Гуаровая камедь), желатин, концентрированный сок из маракуйи, глюкозо-фруктозный сироп, стабилизатор Е 1442 или стабилизатор 1422, или кукурузный крахмал, ароматизаторы, стабилизатор - пектины, краситель - кармины, регулятор кислотности (лимонная кислота, цитрат натрия 3-замещенный), закваска.",
                 price: 640,
                 origin: .russia,
                 weight: 290,
                 measure: .gram,
                 imageName: "yogurt.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 9,
                 name: "Сыр Ламбер полутвердый 50%",
                 type: .dairy,
                 description: "Традиционный Сыр Ламбер, производится из уникального по своим качествам коровьего молока Алтайского края. Этот сыр относится к полутвердым сычужным сортам сыров. В составе есть молоко нормализованное, соль поваренная пищевая, консервант - нитрат калия, краситель - аннато, с использованием бактериального концентрата мезофильных и термофильных бактерий и молокосвертывающего ферментного препарата микробного происхождения.",
                 price: 6845,
                 origin: .russia,
                 weight: 1,
                 measure: .kilogram,
                 imageName: "regularcheese.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 10,
                 name: "Сыр Soft Рассольный",
                 type: .dairy,
                 description: "Рассольные сыры Soft идеально подходят для приготовления салатов из свежих овощей, пиццы и пасты, супов и закусок. В составе есть молоко нормализованное пастеризованное, пальмовое масло, молоко сухое обезжиренное, концентрат молочного белка, соль пищевая, регулятор кислотности глюконо-дельта-лактон, консерванты (Е234, Е202), бактериальная закваска мезофильных и термофильных молочнокислых микроорганизмов, молокосвёртвывающий ферментный препарат животного происхождения.",
                 price: 2220,
                 origin: .russia,
                 weight: 500,
                 measure: .gram,
                 imageName: "softcheese.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             )],
            
            [Product(
                id: 11,
                name: "Груша Конференция",
                type: .fruit,
                description: "Груша хороша сама по себе и как ингредиент многих закусок, салатов, напитков, начинок для пирогов и дичи. Груша отлично сочетается со свежей мятой, мёдом, сырами с голубой плесенью, орехами, рукколой или шпинатом. Грушу сушат, вялят, коптят, запекают, варят из неё компоты, варенья, конфитюры и джемы, при термической обработке практически не уменьшается количество витаминов и минералов, содержащихся в исходном сырье.",
                price: 2210,
                origin: .china,
                weight: 1,
                measure: .kilogram,
                imageName: "pear.jpeg",
                isAvailable: true,
                chosenAmount: 0
            ),
             Product(
                 id: 12,
                 name: "Яблоко Гренни Смит",
                 type: .fruit,
                 description: "В этом фрукте содержится большое количество клетчатки, которая благоприятно сказывается на деятельности кишечника и помогает улучшить работу ЖКТ. В яблоках Гренни Смит фолиевая кислота и витамин А. Стоит также сказать о том, что в состав фрукта входит большое количество калия, который благоприятно сказывается на деятельности сердечнососудистой системы.",
                 price: 1260,
                 origin: .kazakhstan,
                 weight: 1,
                 measure: .kilogram,
                 imageName: "apple.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 13,
                 name: "Бананы",
                 type: .fruit,
                 description: "Бананы десертные обладают плотной, сладкой мякотью и освежающим ароматом с травянистыми нотками. Цвет бананов может варьироваться от салатного до желтого цвета. Спелые и сладкие бананы не нуждаются в представлении: этот тропический фрукт — промокод HLW22 один из самых популярных в Казахстане! Когда-то за бананами выстраивались очереди, а сейчас они есть в каждом доме. Бананы вкусные, сытные, их легко взять в дорогу. Сторонники здорового образа жизни готовят из бананов мороженое: нужно просто очистить бананы, заморозить и затем измельчить с помощью кухонного комбайна. К массе можно добавить любые сиропы, орешки и пряности: это вкусно и полезно! В упаковке допускается попадание плодов с дефектом формы, окраски, небольшим механическим повреждением.",
                 price: 990,
                 origin: .china,
                 weight: 1,
                 measure: .kilogram,
                 imageName: "banan.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 14,
                 name: "Авокадо Хасс",
                 type: .fruit,
                 description: "Знаменитые авокадо сорта «Хасс» с пупырчатой темной кожурой и невероятно вкусной мякотью! Во всем мире эти авокадо ценятся за свой чуть ореховый вкус и отличную «стойкость» при транспортировке. Мякоть авокадо Хасс» — мягкая, нежная, сливочная. Этот сорт считается идеальным для гуакамоле.",
                 price: 1190,
                 origin: .kazakhstan,
                 weight: 1,
                 measure: .kilogram,
                 imageName: "avocado.jpeg",
                 isAvailable: false,
                 chosenAmount: 0
             ),
             Product(
                 id: 15,
                 name: "Слива красная",
                 type: .fruit,
                 description: "Летний фрукт с мясистой мякотью и небольшой кислинкой во вкусе. Слива, как и многие другие фрукты, появляется на нашем столе в середине лета. Из нее варят вкусные компоты и варенья, джемы, повидла, делают домашнюю наливку. Слива прекрасно сочетается со всеми фруктами и подходит для десертов и ассорти, придает им легкую изюминку.",
                 price: 1300,
                 origin: .russia,
                 weight: 1,
                 measure: .piece,
                 imageName: "plum.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 16,
                 name: "Голубика",
                 type: .fruit,
                 description: "Голубика улучшает аппетит, укрепляет стенки сосудов и считается отличным противовоспалительным, желчегонным и мочегонным средством. Также голубика препятствует проявлению склероза, защищает от радиоактивного излучения, снижает уровень сахара в крови и помогает при желудочных и сердечных заболеваниях.",
                 price: 1755,
                 origin: .kazakhstan,
                 weight: 125,
                 measure: .gram,
                 imageName: "blueberry.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 17,
                 name: "Черешня колированная",
                 type: .fruit,
                 description: "Сладкая, крупная, черешня одна из первых ягод появляется на нашем столе, она содержит много полезных веществ, в том числе и микроэлементы. Из черешни можно варить компоты, добавлять в молочные и творожные десерты, красивая форма и цвет позволяют использовать черешню как украшение для тортов и пирожных.",
                 price: 2600,
                 origin: .kazakhstan,
                 weight: 1,
                 measure: .kilogram,
                 imageName: "cherry.jpeg",
                 isAvailable: false,
                 chosenAmount: 0
             ),
             Product(
                 id: 18,
                 name: "Гуява",
                 type: .fruit,
                 description: "Гуява лучше его употреблять свежим, почистив, как яблоко: порезать дольками либо просто пополам. Мякоть употребляют, откусывая кусочки либо вынимая мякоть вилкой. Переспевший плод режут на две части, и вынимают мякоть ложечкой. Плод гуавы считается диетическим не зря. В нем содержится всего 70 ккал на 100г мякоти. Именно потому ее часто включают в диету для диабетиков и при похудении.",
                 price: 10915,
                 origin: .china,
                 weight: 1,
                 measure: .kilogram,
                 imageName: "guava.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 19,
                 name: "Ананас",
                 type: .fruit,
                 description: "Помимо участия в процессе расщепления белков, бромелайн также оказывает противовоспалительное воздействие и борется с отёками. Вместе с содержащейся в ананасе клетчаткой, этот фермент способствует нормализации перистальтики кишечника, благотворно влияет на пищеварение.",
                 price: 1820,
                 origin: .china,
                 weight: 1,
                 measure: .piece,
                 imageName: "pineapple.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 20,
                 name: "Виноград зеленый",
                 type: .fruit,
                 description: "Зеленый виноград — богатый источник питательных веществ, которые помогают нам различными способами. Вот некоторая зеленая виноградная польза для здоровья, знающая, который, Вы поймете истинную важность этих крошечных фруктов(плода).",
                 price: 3510,
                 origin: .russia,
                 weight: 1,
                 measure: .kilogram,
                 imageName: "grape.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             )
            ],
            
            [Product(
                id: 21,
                name: "Чеснок молодой",
                type: .vegetable,
                description: "Чеснок используют в кулинарии как приправу, добавляя его к мясным, овощным и творожным блюдам, супам и маринадам. Чаще всего чеснок очищают и измельчают, но в некоторых рецептах нужно разрезать пополам неочищенную головку чеснока и добавить в блюдо (плов, овощное рагу).",
                price: 190,
                origin: .kazakhstan,
                weight: 1,
                measure: .piece,
                imageName: "garlic.jpeg",
                isAvailable: true,
                chosenAmount: 0
            ),
             Product(
                 id: 22,
                 name: "Томаты на ветке",
                 type: .vegetable,
                 description: "Помидоры богаты витамином С, калием, фолатами и витамином К. Однако больше всего томаты ценны тем, что они являются основным источником мощного антиоксиданта ликопина, который снижает риск сердечных заболеваний и рака. Витамин С. Важное питательное вещество и антиоксидант.",
                 price: 655,
                 origin: .kazakhstan,
                 weight: 1,
                 measure: .kilogram,
                 imageName: "tomato.jpeg",
                 isAvailable: false,
                 chosenAmount: 0
             ),
             Product(
                 id: 23,
                 name: "Картофель",
                 type: .vegetable,
                 description: "Картошка — овощ стратегический и описывать его свойства нет необходимости. Картофель составляет треть рациона овощей современного человека, он вкусный и неприхотливый в хранении, но вот покупка впрок не доставляет нам особого удовольствия. Доставка продуктов на дом решит эту проблему.",
                 price: 310,
                 origin: .china,
                 weight: 1,
                 measure: .kilogram,
                 imageName: "potato.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 24,
                 name: "Огурцы Рава",
                 type: .vegetable,
                 description: "Огурцы обладают определенными лечебными свойствами: повышают аппетит, способствуют хорошему усвоению пищи. Свежие плоды полезны при заболевании желудка (как слабительное средство), печени, почек. Употребление огурцов в пищу способствует выведению воды из организма человека, улучшает работу печени, сердца и почек.",
                 price: 410,
                 origin: .russia,
                 weight: 1,
                 measure: .kilogram,
                 imageName: "cucumber.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 25,
                 name: "Редис пучок",
                 type: .vegetable,
                 description: "Традиционно в пищу употребляют именно корень редиса. Сочетайте плод с любыми другими овощами, яйцами и молочными продуктами. Ботва редиса богата фолиевой кислотой, которая очень полезна для всех женщин, особенно для беременных. Сочную ботву можно измельчить в салат или сварить из нее зеленые щи.",
                 price: 325,
                 origin: .kazakhstan,
                 weight: 1,
                 measure: .piece,
                 imageName: "radish.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 26,
                 name: "Морковь Казахстан",
                 type: .vegetable,
                 description: "Морковка — это один из основных овощей в рационе наравне с луком и картофелем.Она полезна, вкусна, подойдет как самостоятельное блюдо и как добавка к супам, вторым блюдам, пассировкам и гарнирам. ",
                 price: 395,
                 origin: .kazakhstan,
                 weight: 1,
                 measure: .kilogram,
                 imageName: "carrot.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 27,
                 name: "Капуста краснокочанная",
                 type: .vegetable,
                 description: "Краснокочанная капуста слаще на вкус, кроме салатов ее можно использовать как гарнир к мясным блюдам или самостоятельно. Чтобы сохранить цвет этого овоща в процессе готовки, добавьте немного уксуса или лимонного сока.",
                 price: 885,
                 origin: .kazakhstan,
                 weight: 1,
                 measure: .kilogram,
                 imageName: "cabbage.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 28,
                 name: "Шампиньоны WhiteCap Белые",
                 type: .vegetable,
                 description: "Шампиньоны варят, жарят, тушат, запекают, готовят на гриле. Супы, жульены, овощные рагу, омлеты, начинки для пирогов и блинчиков, грибные паштеты, фаршированные шляпки, соусы для пасты, грибные пиццы, традиционные грибы, жареные с луком и картошкой.",
                 price: 2080,
                 origin: .kazakhstan,
                 weight: 1,
                 measure: .kilogram,
                 imageName: "mushroom.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 29,
                 name: "Артишок средний",
                 type: .vegetable,
                 description: "Артишоки - это овощ, который хорошо сочетается с рисом, картофелем, птицей, говядиной, крольчатиной, красной и белой рыбой. Их смешивают с разнами травами, сметаной, овощами, поливают растительными маслами. Запивают белым полусухим или сухим вином. Хорошо дополняют вкус черный перец, орехи кедра, мускатный орех, оливки, изюм и кунжут.",
                 price: 3495,
                 origin: .china,
                 weight: 1,
                 measure: .piece,
                 imageName: "artichoke.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             ),
             Product(
                 id: 30,
                 name: "Баклажаны Казахстан",
                 type: .vegetable,
                 description: "Баклажаны очень хороши в жареном, печеном и тушеном виде. Для любителей баклажанной икры есть одна маленькая хитрость: она будет намного вкуснее, если ее приготовить из печеных плодов. ",
                 price: 1170,
                 origin: .kazakhstan,
                 weight: 1,
                 measure: .kilogram,
                 imageName: "eggplant.jpeg",
                 isAvailable: true,
                 chosenAmount: 0
             )
            ]
        ]
    }
}
