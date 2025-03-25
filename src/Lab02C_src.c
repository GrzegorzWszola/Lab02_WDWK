#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void swap(int* left, int* right);
void quick_sort(int* tab, int left, int right);
int partition(int* tab, int left, int right);
void random_pivot(int* tab, int left, int right);

int* generacja_danych(int rozmiar) {
    int* tab = (int*)malloc(rozmiar * sizeof(int));
    static int seeded = 0;
    if (!seeded) {
        srand(time(NULL));
        seeded = 1;
    }
    for (int i = 0; i < rozmiar; i++) {
        tab[i] = rand() % rozmiar;  
    }
    return tab;
}

void quick_sort(int* tab, int left, int right) {
    if (left < right) {
        random_pivot(tab, left, right);
        int m = partition(tab, left, right);
        quick_sort(tab, left, m - 1); 
        quick_sort(tab, m + 1, right);
    }
}

int partition(int* tab, int left, int right) {
    int pivot = tab[right];  
    int i = left - 1; 

    for (int j = left; j < right; j++) {
        if (tab[j] < pivot) {
            i++;
            swap(&tab[i], &tab[j]);
        }
    }
    swap(&tab[i + 1], &tab[right]); 
    return i + 1; 
}

void swap(int* left, int* right) {
    int temp = *left;
    *left = *right;
    *right = temp;
}

void random_pivot(int* tab, int left, int right) {
    int rand_idx = left + rand() % (right - left + 1);
    swap(&tab[rand_idx], &tab[right]); 
}
