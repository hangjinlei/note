# C++

## input and output

1. `std::cin >> name`
1. `std::cin >> name >> age`
1. `std::getline(std::cin, fullName) // If the input contains space`

output

1. `std::cout >> "name: " >> name >> std::endl`
1. `std::cerr >> "name: " >> name >> std::endl`
1. `std::clog >> "name: " >> name >> std::endl`

## Numbers

1. `int number1{15};          // Decimal`
2. `int number2(017);         // Octal`
3. `int number3 = 0x0F;       // Hexadecimal`
4. `int number4 = 0b00001111; // Binary - C++14`

-   braced initialization `int a{10};`
-   function initialization `int b(20);`
-   assignment initialization `int c = 30;`

int modifiers

1. `short int si{10};`
1. `int i{10};`
1. `long int li{10};`
1. `long long int lli{10};`

size of int

1. `std::cout << sizeof(si) << std::endl;  // 2 bytes`
1. `std::cout << sizeof(i) << std::endl;   // 4 bytes`
1. `std::cout << sizeof(li) << std::endl;  // 4 bytes`
1. `std::cout << sizeof(lli) << std::endl; // 8 bytes`

double modifiers

1. `float f{10.5f};`
1. `double d{10.5};`
1. `long double ld{10.5l};`

size of double

1. `std::cout << sizeof(f) << std::endl;  // 4 bytes`
1. `std::cout << sizeof(d) << std::endl;  // 8 bytes`
1. `std::cout << sizeof(ld) << std::endl; // 8 bytes`

auto keyword

-   `auto var1{12};`
-   `auto var2{13.0};`
-   `auto var3{14.0f};`
-   `auto var4{15.0l};`
-   `auto var5{'e'};`
-   `auto var6{123u};  // unsigned`
-   `auto var7{123ul}; // unsigned long`
-   `auto var8{123ll}; // long long`
