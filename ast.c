#include <stdio.h>
#include <stdlib.h>
#include "ast.h"

ASTNode* create_node(NodeType type, char* info, ASTNode* left, ASTNode* right) {
    ASTNode* node = malloc(sizeof(ASTNode));
    node->type = type;
    node->info = info;
    node->left = left;
    node->right = right;
    return node;
}

void print_ast(ASTNode* node, int indent) {
    if (!node) return;

    for (int i = 0; i < indent; ++i) printf("  ");

    switch (node->type) {
        case DATE: printf("DATE(%s)\n", node->info); break;
        case NUM:  printf("NUM(%s)\n", node->info); break;
        case BOOL_OP: printf("BOOL_OP(%s)\n", node->info); break;
        case DATE_OP: printf("DATE_OP(%s)\n", node->info); break;
        case CREATE_TASK: printf("CREATE_TASK(%s)\n", node->info); break;
        case CREATE_TAG: printf("CREATE_TAG(%s)\n", node->info); break;
        case DELETE_TASK: printf("DELETE_TASK(%s)\n", node->info); break;
        case DELETE_TAG: printf("DELETE_TAG(%s)\n", node->info); break;
        case SHOW_TAG: printf("SHOW_TAG(%s)\n", node->info); break;
        case SHOW_TASK: printf("SHOW_TASK(%s)\n", node->info); break;
    }

    if (node->left) print_ast(node->left, indent + 1);
    if (node->right) print_ast(node->right, indent + 1);
}

void free_ast(ASTNode* node) {
    if (!node) return;
    free_ast(node->left);
    free_ast(node->right);
    free(node);
}
