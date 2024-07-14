part of '../home.dart';

class Toolbar extends HookConsumerWidget with HomeState, HomeEvent {
  const Toolbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = todoListFilter(ref);

    Color? textColorFor(TodoListFilter value) {
      return filter == value ? Colors.blue : Colors.black;
    }

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${uncompletedTodosCount(ref)} itens restantes',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Tooltip(
            key: allFilterKey,
            message: 'Todas as tarefas',
            child: TextButton(
              onPressed: () =>
                  changeFilterCategory(ref, filter: TodoListFilter.all),
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor:
                    MaterialStateProperty.all(textColorFor(TodoListFilter.all)),
              ),
              child: const Text('Todas'),
            ),
          ),
          Tooltip(
            key: activeFilterKey,
            message: 'Apenas tarefas incompletas',
            child: TextButton(
              onPressed: () =>
                  changeFilterCategory(ref, filter: TodoListFilter.active),
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: MaterialStateProperty.all(
                  textColorFor(TodoListFilter.active),
                ),
              ),
              child: const Text('Ativo'),
            ),
          ),
          Tooltip(
            key: completedFilterKey,
            message: 'Apenas tarefas incompletas',
            child: TextButton(
              onPressed: () =>
                  changeFilterCategory(ref, filter: TodoListFilter.completed),
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: MaterialStateProperty.all(
                  textColorFor(TodoListFilter.completed),
                ),
              ),
              child: const Text('Completa'),
            ),
          ),
        ],
      ),
    );
  }
}
