import 'package:clean_riverpod_management/src/extension/list_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'home_event_test.dart';
import 'home_state_test.dart';
import 'provider_container.dart';

void main() {
  final homeEvent = HomeEventTest();
  final homeState = HomeStateTest();

  test('Adicionar atividade', () {
    final container = createContainer();
    const String todoDescription = 'Escreva uma atividade de teste';
    homeEvent.addTodo(container,
        textEditingController: TextEditingController(), value: todoDescription);

    expect(
        homeState.filteredTodos(container).last.description, todoDescription);
  });

  test('Remover tarefa', () {
    final container = createContainer();
    final selectedTodo = homeState.filteredTodos(container).last;
    homeEvent.removeTodo(container, selectedTodo: selectedTodo);

    expect(
        homeState
            .filteredTodos(container)
            .firstWhereOrNull((e) => e.id == selectedTodo.id),
        null);
  });

  test('Mudar tarefa', () {
    final container = createContainer();
    final selectedTodo = homeState.filteredTodos(container).last;
    homeEvent.toggleTodoState(container, todoId: selectedTodo.id);

    expect(
        homeState
            .filteredTodos(container)
            .firstWhere((e) => e.id == selectedTodo.id)
            .completed,
        true);
  });

  test('remover ->  add -> mudar tarefa', () {
    /// remove last element of todoList
    final container = createContainer();
    final removedTodo = homeState.filteredTodos(container).last;
    homeEvent.removeTodo(container, selectedTodo: removedTodo);

    /// add todo
    const String todoDescription = 'Escreva uma tarefa';
    homeEvent.addTodo(container,
        textEditingController: TextEditingController(), value: todoDescription);

    /// change todo state
    final targetTodo = homeState.filteredTodos(container).last;
    homeEvent.toggleTodoState(container, todoId: targetTodo.id);

    expect(
        homeState
            .filteredTodos(container)
            .firstWhere((e) => e.id == targetTodo.id)
            .completed,
        true);
    expect(homeState.uncompletedTodosCount(container), 2);
    expect(homeState.filteredTodos(container).length, 3);
  });
}
