/*
 * Compile: gcc whiskeyDB.c -lsqlite3
 */
#include <stdio.h>
#include <stdlib.h>
#include <sqlite3.h>

void query1(sqlite3 *dbHandle);
void query2(sqlite3 *dbHandle);
void query3(sqlite3 *dbHandle);

int main(int argc, char* args[]) {

    sqlite3 *dbHandle;         // Database connection handle

    /* Path to the whiskeyDB SQLite database file */
    char *dbFile = "./sqlite/whiskey.db";

    /* Opens the whiskeyDB SQLite database file */
    int returnCode = sqlite3_open(dbFile, &dbHandle);

    /* Check that the database was opened correctly */
    if (returnCode != SQLITE_OK) {
        fprintf(stderr, "Cannot open database: %s\n", 
                sqlite3_errmsg(dbHandle));
        sqlite3_close(dbHandle);
        return 1;
    }

    int userInput;
    int scanfReturn;

    while (1) {

        /* TODO: Add quote on seeking knowledge. Only show once. */
        printf("Seek Knowledge\n");
        printf("Enter the number for the question you would like to ask.\n\n");
        printf("1: What are the names and prices of all bottles purchased?\n");
        printf("2: How many total bottles have been purchased?\n");
        printf("3: What bottles are available in the house?\n");

        scanfReturn = scanf("%d", &userInput);

        if (scanfReturn == EOF) {
            printf("Error reading user input.\n");
            exit(1);
            continue;
        }
        if (scanfReturn == 0) {
            printf("User input is invalid.\n\n");
            while (fgetc(stdin) != '\n');
            continue;
        }

        switch (userInput) {
            case 1:
                printf("\n");
                query1(dbHandle);
                break;
            case 2:
                printf("\n");
                query2(dbHandle);
                break;
            case 3:
                printf("\n");
                query3(dbHandle);
                break;
            default:
                printf("Invalid number. Please enter a number from above.\n");
        }

        while (fgetc(stdin) != '\n');   // get rid of unwanted input

        printf("Press Enter to perform another search.\n");
        char enter = getchar();
        while (enter != '\n') {
            enter = getchar();
        }
    }

    sqlite3_close(dbHandle);
}

void query1(sqlite3 *dbHandle) {
    sqlite3_stmt *stmtHandle;  // Prepared statement object
    int returnCode;            // Value returned from SQLite functions

    char *sqlStmt = "SELECT Bottle.name, Purchase.price "
                      "FROM Purchase "
                      "JOIN Bottle ON Purchase.bottleID = Bottle.bottleID "
                  "ORDER BY Purchase.price";

    returnCode = sqlite3_prepare_v2(dbHandle, sqlStmt, -1, 
            &stmtHandle, 0);

    if (returnCode != SQLITE_OK) {
        fprintf(stderr, "Query 1: Failed to perform query: %s\n", 
                sqlite3_errmsg(dbHandle));
        sqlite3_close(dbHandle);
        exit(1);
    }

    printf("%-40s%s\n", "Name", "Price");
    printf("%-40s%s\n", "----", "-----");

    while (1) {
        returnCode = sqlite3_step(stmtHandle);

        if (returnCode == SQLITE_ROW) {
            printf("%-40s$%.2f\n", sqlite3_column_text(stmtHandle, 0), 
                    sqlite3_column_double(stmtHandle, 1));
        } else {
            printf("\n");
            break;
        }
    }

    sqlite3_finalize(stmtHandle);
}

void query2(sqlite3 *dbHandle) {
    sqlite3_stmt *stmtHandle;  // Prepared statement object
    int returnCode;            // Value returned from SQLite functions

    char *sqlStmt = "SELECT COUNT(*) "
                      "FROM Purchase";

    returnCode = sqlite3_prepare_v2(dbHandle, sqlStmt, -1, 
            &stmtHandle, 0);

    if (returnCode != SQLITE_OK) {
        fprintf(stderr, "Query 2: Failed to perform query: %s\n", 
                sqlite3_errmsg(dbHandle));
        sqlite3_close(dbHandle);
        exit(1);
    }

    while (1) {
        returnCode = sqlite3_step(stmtHandle);

        if (returnCode == SQLITE_ROW) {
            printf("%s bottles have been purchased.\n", 
                    sqlite3_column_text(stmtHandle, 0));
        } else {
            printf("\n");
            break;
        }
    }

    sqlite3_finalize(stmtHandle);
}

void query3(sqlite3 *dbHandle) {
    sqlite3_stmt *stmtHandle;  // Prepared statement object
    int returnCode;            // Value returned from SQLite functions

    char *sqlStmt = "SELECT Bottle.name "
                      "FROM Purchase "
                      "JOIN Bottle ON Purchase.bottleID = Bottle.bottleID "
                     "WHERE onShelf = 1";
                  //"ORDER BY Purchase.price";

    returnCode = sqlite3_prepare_v2(dbHandle, sqlStmt, -1, 
            &stmtHandle, 0);

    if (returnCode != SQLITE_OK) {
        fprintf(stderr, "Query 3: Failed to perform query: %s\n", 
                sqlite3_errmsg(dbHandle));
        sqlite3_close(dbHandle);
        exit(1);
    }

    printf("The following bottles are available on the shelf:\n\n");

    while (1) {
        returnCode = sqlite3_step(stmtHandle);

        if (returnCode == SQLITE_ROW) {
            printf("%s\n", sqlite3_column_text(stmtHandle, 0));
        } else {
            printf("\n");
            break;
        }
    }

    sqlite3_finalize(stmtHandle);
}
