#include <string.h>
#include <stdio.h>
#include <stdlib.h>

// struct my_date{
//     short day;
//     short month;
//     int year;
// }age;

// void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages){
//      for(int i=0; i<len; i++){
//          int age=present->year-(dates+i)->year;
//          if((dates+i)->month>present->month)
//             age--;
//          if((dates+i)->month==present->month){
//              if((dates+i)->day>present->day){
//                  age--;
//              }
//          }
//          if(age<0)
//             *(all_ages+i)=0;
//         else *(all_ages+i)=age;
//      }
// }
int len_cheie, len_haystack;
void columnar_transposition(int key[], char *haystack, char *ciphertext)
{
    int i = 0;
    for (int p = 0; p < len_cheie; p++)
    {
        ciphertext[i] = haystack[key[p]];
        for (int j = key[p]; j < len_haystack; j += len_cheie)
        {
            ciphertext[i] = haystack[j];
            printf("%c", ciphertext[i]);
            i++;
        }
    }
}

int main()
{
    int key[] = {0, 2, 4, 1, 3};
    char *haystack = "Nu te intreba nimeni nimic!";
    char *ciphertext = malloc(100 * sizeof(char));
    len_haystack = 27;
    len_cheie = 5;
    columnar_transposition(key, haystack, ciphertext);
}