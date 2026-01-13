# EAN-Worker:

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) ![10 Seattle](https://github.com/user-attachments/assets/c70b7f21-688a-4239-87c9-9a03a8ff25ab) ![10 1 Berlin](https://github.com/user-attachments/assets/bdcd48fc-9f09-4830-b82e-d38c20492362) ![10 2 Tokyo](https://github.com/user-attachments/assets/5bdb9f86-7f44-4f7e-aed2-dd08de170bd5) ![10 3 Rio](https://github.com/user-attachments/assets/e7d09817-54b6-4d71-a373-22ee179cd49c)  ![10 4 Sydney](https://github.com/user-attachments/assets/e75342ca-1e24-4a7e-8fe3-ce22f307d881) ![11 Alexandria](https://github.com/user-attachments/assets/64f150d0-286a-4edd-acab-9f77f92d68ad) ![12 Athens](https://github.com/user-attachments/assets/59700807-6abf-4e6d-9439-5dc70fc0ceca)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) ![None](https://github.com/user-attachments/assets/30ebe930-c928-4aaf-a8e1-5f68ec1ff349)  
![Description](https://github.com/user-attachments/assets/dbf330e0-633c-4b31-a0ef-b1edb9ed5aa7) ![BarCode pas](https://github.com/user-attachments/assets/ff057a8b-a272-41a5-84b2-57479b6c2711)  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) ![012026](https://github.com/user-attachments/assets/ae91e595-2dbf-4d94-b953-81e4fd25dcc3)   
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)  

</br>

The European Article Number (often shortened to EAN) is a standard to encode product numbers. The EAN is a special case of a [Global Trade Item Number](https://simple.wikipedia.org/wiki/Global_Trade_Item_Number?action=edit&redlink=1). The EAN is made of either 8 or 13 digits (EAN-8, and EAN-13). In many cases, the EAN allows to uniquely identify the item. Most of the time, the EAN is printed on the packaging of a product. Special scanners are able to decode these numbers. They then look up the product-specific data (such as the price) and print it on the bill, for example.

Note that the EAN is often encoded using a [barcode](https://simple.wikipedia.org/wiki/Barcode) (such as the ones in the example), but this does not have to be the case. There are other machine-readable codes which can also be used.

</br>

![EAN](https://github.com/user-attachments/assets/17b32833-920d-413d-9144-f081f4409b32)

</br>

### EAN-13/GTIN-13:
The standard EAN has 13 digits. The EAN is composed of different sections:

* ```Country-specific part: 3 digits```
* ```Company part```
* ```Article number: 3-5 digits```
* ```Checksum digit```

### EAN-8/GTIN-8:
The normal length of an EAN is 13 digits. There is also a shorter version called EAN-8, for small packages, where the full 13-digit number would take too much space on the package. The EAN-8 consists of:

* ```Country-specific part: 2-3 digits```
* ```Article number: 4-5 digits```
* ```Checksum digit```

There are special organisations which give out both EAN-8 and EAN-13 numbers. Since EAN-8 numbers with a starting digit 2 are free use, many retailers (such as Aldi) use them for their own products. As an example, Aldi uses EAN-8 codes starting with 290 or 221; 290 and 221 are the country-specific parts "for internal use".

# Barcode structure:
The barcode consists of 95 areas (also called modules of equal width. Each area can be either white (represented here as 0) or black (represented as 1). From left to right:

* ```3 areas for the start marker (101)```
* ```42 areas (seven per digit) to encode digits 2–7, and to encode digit 1 indirectly, as described in the following section```
* ```5 areas for the center marker (01010)```
* ```42 areas (seven per digit) to encode digits 8–13```
* ```3 areas for the end marker (101)```

</br>

![EAN-Structure](https://github.com/user-attachments/assets/ecf6a984-a44f-4f01-a548-57346e7ca8aa)

</br>

The most widely used EAN code is the EAN-13 code. As its name suggests, it is composed of 13 digits, structured in three parts  :

* The company prefix  : the first three digits represent the country of origin of the product (France  : 300 to 379)
* The article number  :
  * the next five digits correspond to the manufacturer’s code (from 0 to 99  999)
  * From 8 to 12 th digit, these are the numbers corresponding to the manufacturer’s product. So there are 99  999 possibilities for each manufacturer. These figures are ”  free  That is, each manufacturer can choose the numbers used.
* The control key  : the 13 th and last digit is a check digit  : it is calculated according to the first 12 digits of the EAN. This key is used to validate the barcode.

This code is symbolized by a sequence of white and black bars, thus becoming a bar code.

# Encoding of the digits:
To encode the 13-digit EAN-13 number, the digits are split into 3 groups; the first digit, the first group of 6 and the last group of 6. The first group of 6 is encoded using a pattern whereby each digit has two possible encodings, one of which has even parity (denoted with letter G) and one of which has odd [parity](https://en.wikipedia.org/wiki/Parity_bit#Parity) (denoted with letter L). The first digit is not represented directly by a pattern of bars and spaces, but is encoded indirectly, by selecting a pattern of choices between these two encodings for the first group of 6 digits, according to the table below. All digits in the last group of 6 digits are encoded using a single pattern RRRRRR, the one also used for [UPC](https://en.wikipedia.org/wiki/Universal_Product_Code).

### Structure of EAN-13:
</br>

| First digit | First group of 6 digits | Last group of 6 digits |
| :-----------: | :-----------: | :-----------: |
| 0     | LLLLLL     | RRRRRR     |
| 1     | LLGLGG     | RRRRRR     |
| 2     | LLGGLG     | RRRRRR     |
| 3     | LLGGGL     | RRRRRR     |
| 4     | LGLLGG     | RRRRRR     |
| 5     | LGGLLG     | RRRRRR     |
| 6     | LGGGLL     | RRRRRR     |
| 7     | LGLGLG     | RRRRRR     |
| 8     | LGLGGL     | RRRRRR     |
| 9     | LGGLGL     | RRRRRR     |

</br>

This encoding guarantees that the first group always starts with an L-code, which has odd parity, and that the second group always starts with an R-code, which has even parity. Thus, it does not matter whether the barcode is scanned from the left or from the right, as the scanning software can use this parity to identify the start and end of the code.









