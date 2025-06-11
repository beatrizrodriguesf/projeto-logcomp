#ifndef AST_H
#define AST_H

typedef enum {
    DATE,
    NUM,
    DESCRIPTION,
    BOOL_OP,
    DATE_OP,
    REPEAT,
    CREATE_TASK,
    CREATE_TAG,
    DELETE_TASK,
    DELETE_TAG,
    SHOW_TAG,
    SHOW_TASK,
} NodeType;

typedef struct ASTNode {
    NodeType type;
    char* info;
    struct ASTNode* left;
    struct ASTNode* right;
} ASTNode;

ASTNode* create_node(NodeType type, char* info, ASTNode* left, ASTNode* right);
void print_ast(ASTNode* node, int indent);
void free_ast(ASTNode* node);

#endif
