# Implementing String in Metal for use on GPU
The C++ String class implemented in Metal (MSL).

## Definitions:

#### Type Conversion:
```int stoi(const char str[])```  

```long stol(const char str[])```  

```unsigned int stoul(const char str[])```  

```float stof(const char str[])```  

#### Capacity:
```size_t length(const char str[])```  

```size_t size(const char str[])```  

```size_t max_size(const char str[])```

```void clear(char str[])```  

```bool empty(char str[])```  

#### Element access:
```char at(const char str[], size_t pos)```  

```char back(const char str[])```  

```char front(const char str[])```  

#### Modifiers:
```void append(char dest[], const char src[])```  

```void push_back(char str[], char c)```  

```void assign(char dest[], const char src[])```  

```void assign(char dest[], const char src[], size_t subpos, size_t sublen)```  

```void assign(char dest[], const char src[], size_t sublen)```  

```void assign(char str[], size_t n, char c)```  

```void insert(char dest[], size_t pos, const char src[])```  

```void insert(char dest[], size_t pos, const char src[], size_t subpos, size_t sublen)```  

```void insert(char dest[], size_t pos, const char src[], size_t sublen)```  

```void insert(char dest[], size_t pos, size_t n, const char src[], size_t sublen)```  

```void erase(char str[], size_t pos, size_t len)```  

```void replace(char dest[], size_t pos, size_t len, const char src[])```  

```void replace(char dest[], size_t pos, size_t len, const char src[], size_t subpos, size_t sublen)```  

```void replace(char dest[], size_t pos, size_t len, const char src[], size_t sublen)```  

```void replace(char dest[], size_t pos, size_t len, char c)```  

```void swap(char swap1[], char swap2[])```  

```void pop_back(char str[])```  

#### String operations:
```void copy(char dest[], const char src[], size_t len, size_t pos)```  

```size_t find(const char full_str[], const char search_substr[])```  

```size_t find(const char full_str[], const char search_substr[], size_t pos)```  

```size_t find(const char str[], char c)```  

```size_t find(const char str[], char c, size_t pos)```  

```size_t rfind(const char full_str[], const char search_substr[])```  

```size_t rfind(const char full_str[], const char search_substr[], size_t pos)```  

```size_t rfind(const char str[], char c)```  

```size_t rfind(const char str[], char c, size_t pos)```  

```size_t find_first_of (const char str[], const char chars[])```  

```size_t find_first_of (const char str[], const char chars[], size_t pos)```  

```size_t find_first_of (const char str[], char c)```  

```size_t find_first_of (const char str[], char c, size_t pos)```  

```size_t find_last_of(const char str[], const char chars[])```  

```size_t find_last_of(const char str[], const char chars[], size_t pos)```  

```size_t find_last_of(const char str[], char c)```  

```size_t find_last_of(const char str[], char c, size_t pos)```  

```size_t find_first_not_of(const char str[], const char chars[])```  

```size_t find_first_not_of(const char str[], const char chars[], size_t pos)```  

```size_t find_first_not_of(const char str[], const char c)```  

```size_t find_first_not_of(const char str[], const char c, size_t pos)```  

```size_t find_last_not_of(const char str[], const char chars[])```  

```size_t find_last_not_of(const char str[], const char chars[], size_t pos)```  

```size_t find_last_not_of(const char str[], char c)```  

```size_t find_last_not_of(const char str[], char c, size_t pos)```  

```void substr(char dest[], const char src[], size_t pos, size_t len)```  

```int compare(const char str[], const char compare_str[])```  

```int compare(const char str[], size_t compare_str_pos, size_t compare_str_len, const char compare_str[])``` 

## Performance

| string len | substr len | find runtime |
|------------|------------|--------------|
| 5          | 1          | 0.9181 ms    |
| 10         | 1          | 1.2051 ms    |
| 10         | 5          | 1.2539 ms    |
| 25         | 1          | 1.1419 ms    |
| 25         | 5          | 1.0914 ms    |
| 25         | 10         | 1.1402 ms    |
| 50         | 1          | 1.1923 ms    |
| 50         | 5          | 2.3409 ms    |
| 50         | 10         | 1.7257 ms    |
| 50         | 25         | 4.1751 ms    |
| 100        | 1          | 1.5150 ms    |
| 100        | 5          | 1.8975 ms    |
| 100        | 10         | 2.3663 ms    |
| 100        | 25         | 2.9884 ms    |
| 100        | 50         | 3.2206 ms    |

(averaged for 10 runs where substr wasn't in string)  



## References  
https://cplusplus.com/reference/string/string/  
https://developer.apple.com/metal/
