#!/bin/bash

# Clean Architecture Feature Generator with Cubit
# Usage: ./create_feature_cubit.sh feature_name

if [ -z "$1" ]; then
  echo "❌ Error: Feature name is required"
  echo "Usage: ./create_feature_cubit.sh feature_name"
  echo "Example: ./create_feature_cubit.sh product"
  exit 1
fi

FEATURE_NAME=$1
FEATURE_NAME_LOWER=$(echo "$FEATURE_NAME" | tr '[:upper:]' '[:lower:]')
FEATURE_NAME_PASCAL=$(echo "$FEATURE_NAME" | sed 's/_\([a-z]\)/\U\1/g' | sed 's/^\([a-z]\)/\U\1/')

echo "🚀 Creating Clean Architecture Feature with Cubit: $FEATURE_NAME_PASCAL"

# Create directories
mkdir -p "lib/features/$FEATURE_NAME_LOWER/data/models"
mkdir -p "lib/features/$FEATURE_NAME_LOWER/data/datasources"
mkdir -p "lib/features/$FEATURE_NAME_LOWER/data/repositories"
mkdir -p "lib/features/$FEATURE_NAME_LOWER/domain/entities"
mkdir -p "lib/features/$FEATURE_NAME_LOWER/domain/repositories"
mkdir -p "lib/features/$FEATURE_NAME_LOWER/domain/usecases"
mkdir -p "lib/features/$FEATURE_NAME_LOWER/presentation/cubit"
mkdir -p "lib/features/$FEATURE_NAME_LOWER/presentation/pages"
mkdir -p "lib/features/$FEATURE_NAME_LOWER/presentation/widgets"

echo "📁 Created directory structure"

# Create Entity
cat > "lib/features/$FEATURE_NAME_LOWER/domain/entities/${FEATURE_NAME_LOWER}_entity.dart" << EOF
import 'package:equatable/equatable.dart';
import '../../../../core/base/base_entity.dart';

class ${FEATURE_NAME_PASCAL}Entity extends BaseEntity with EquatableMixin {
  final int id;
  final String name;
  // TODO: Add your entity properties

  const ${FEATURE_NAME_PASCAL}Entity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
EOF

echo "✅ Created Entity"

# Create Model
cat > "lib/features/$FEATURE_NAME_LOWER/data/models/${FEATURE_NAME_LOWER}_model.dart" << EOF
import 'package:equatable/equatable.dart';
import '../../../../core/base/base_entity.dart';
import '../../domain/entities/${FEATURE_NAME_LOWER}_entity.dart';

class ${FEATURE_NAME_PASCAL}Model with EquatableMixin {
  final int id;
  final String name;
  // TODO: Add your model properties

  const ${FEATURE_NAME_PASCAL}Model({
    required this.id,
    required this.name,
  });

  ${FEATURE_NAME_PASCAL}Entity toEntity() {
    return ${FEATURE_NAME_PASCAL}Entity(
      id: id,
      name: name,
    );
  }

  factory ${FEATURE_NAME_PASCAL}Model.fromJson(Map<String, dynamic> json) {
    return ${FEATURE_NAME_PASCAL}Model(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory ${FEATURE_NAME_PASCAL}Model.fromEntity(${FEATURE_NAME_PASCAL}Entity entity) {
    return ${FEATURE_NAME_PASCAL}Model(
      id: entity.id,
      name: entity.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
EOF

echo "✅ Created Model"

# Create Repository Interface
cat > "lib/features/$FEATURE_NAME_LOWER/domain/repositories/${FEATURE_NAME_LOWER}_repository.dart" << EOF
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/${FEATURE_NAME_LOWER}_entity.dart';

abstract class ${FEATURE_NAME_PASCAL}Repository {
  Future<Either<Failure, List<${FEATURE_NAME_PASCAL}Entity>>> getAll();
  Future<Either<Failure, ${FEATURE_NAME_PASCAL}Entity>> getById(int id);
  Future<Either<Failure, ${FEATURE_NAME_PASCAL}Entity>> create(${FEATURE_NAME_PASCAL}Entity entity);
  Future<Either<Failure, ${FEATURE_NAME_PASCAL}Entity>> update(${FEATURE_NAME_PASCAL}Entity entity);
  Future<Either<Failure, void>> delete(int id);
}
EOF

echo "✅ Created Repository Interface"

# Create Data Source
cat > "lib/features/$FEATURE_NAME_LOWER/data/datasources/${FEATURE_NAME_LOWER}_remote_datasource.dart" << EOF
import '../../../../core/network/dio_client.dart';
import '../models/${FEATURE_NAME_LOWER}_model.dart';

abstract class ${FEATURE_NAME_PASCAL}RemoteDataSource {
  Future<List<${FEATURE_NAME_PASCAL}Model>> getAll();
  Future<${FEATURE_NAME_PASCAL}Model> getById(int id);
  Future<${FEATURE_NAME_PASCAL}Model> create(${FEATURE_NAME_PASCAL}Model model);
  Future<${FEATURE_NAME_PASCAL}Model> update(${FEATURE_NAME_PASCAL}Model model);
  Future<void> delete(int id);
}

class ${FEATURE_NAME_PASCAL}RemoteDataSourceImpl implements ${FEATURE_NAME_PASCAL}RemoteDataSource {
  final DioClient client;

  ${FEATURE_NAME_PASCAL}RemoteDataSourceImpl(this.client);

  @override
  Future<List<${FEATURE_NAME_PASCAL}Model>> getAll() async {
    final response = await client.get('/${FEATURE_NAME_LOWER}s');
    return (response.data as List)
        .map((json) => ${FEATURE_NAME_PASCAL}Model.fromJson(json))
        .toList();
  }

  @override
  Future<${FEATURE_NAME_PASCAL}Model> getById(int id) async {
    final response = await client.get('/${FEATURE_NAME_LOWER}s/\$id');
    return ${FEATURE_NAME_PASCAL}Model.fromJson(response.data);
  }

  @override
  Future<${FEATURE_NAME_PASCAL}Model> create(${FEATURE_NAME_PASCAL}Model model) async {
    final response = await client.post(
      '/${FEATURE_NAME_LOWER}s',
      data: model.toJson(),
    );
    return ${FEATURE_NAME_PASCAL}Model.fromJson(response.data);
  }

  @override
  Future<${FEATURE_NAME_PASCAL}Model> update(${FEATURE_NAME_PASCAL}Model model) async {
    final response = await client.put(
      '/${FEATURE_NAME_LOWER}s/\${model.id}',
      data: model.toJson(),
    );
    return ${FEATURE_NAME_PASCAL}Model.fromJson(response.data);
  }

  @override
  Future<void> delete(int id) async {
    await client.delete('/${FEATURE_NAME_LOWER}s/\$id');
  }
}
EOF

echo "✅ Created Remote Data Source"

# Create Repository Implementation
cat > "lib/features/$FEATURE_NAME_LOWER/data/repositories/${FEATURE_NAME_LOWER}_repository_impl.dart" << EOF
import 'package:dartz/dartz.dart';
import '../../../../core/base/base_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/${FEATURE_NAME_LOWER}_entity.dart';
import '../../domain/repositories/${FEATURE_NAME_LOWER}_repository.dart';
import '../datasources/${FEATURE_NAME_LOWER}_remote_datasource.dart';
import '../models/${FEATURE_NAME_LOWER}_model.dart';

class ${FEATURE_NAME_PASCAL}RepositoryImpl extends BaseRepository implements ${FEATURE_NAME_PASCAL}Repository {
  final ${FEATURE_NAME_PASCAL}RemoteDataSource remoteDataSource;

  ${FEATURE_NAME_PASCAL}RepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<${FEATURE_NAME_PASCAL}Entity>>> getAll() async {
    return execute(
      apiCall: () async {
        final models = await remoteDataSource.getAll();
        return models.map((model) => model.toEntity()).toList();
      },
    );
  }

  @override
  Future<Either<Failure, ${FEATURE_NAME_PASCAL}Entity>> getById(int id) async {
    return execute(
      apiCall: () async {
        final model = await remoteDataSource.getById(id);
        return model.toEntity();
      },
    );
  }

  @override
  Future<Either<Failure, ${FEATURE_NAME_PASCAL}Entity>> create(${FEATURE_NAME_PASCAL}Entity entity) async {
    return execute(
      apiCall: () async {
        final model = ${FEATURE_NAME_PASCAL}Model.fromEntity(entity);
        final created = await remoteDataSource.create(model);
        return created.toEntity();
      },
    );
  }

  @override
  Future<Either<Failure, ${FEATURE_NAME_PASCAL}Entity>> update(${FEATURE_NAME_PASCAL}Entity entity) async {
    return execute(
      apiCall: () async {
        final model = ${FEATURE_NAME_PASCAL}Model.fromEntity(entity);
        final updated = await remoteDataSource.update(model);
        return updated.toEntity();
      },
    );
  }

  @override
  Future<Either<Failure, void>> delete(int id) async {
    return execute(
      apiCall: () => remoteDataSource.delete(id),
    );
  }
}
EOF

echo "✅ Created Repository Implementation"

# Create UseCase
cat > "lib/features/$FEATURE_NAME_LOWER/domain/usecases/get_${FEATURE_NAME_LOWER}s_usecase.dart" << EOF
import 'package:dartz/dartz.dart';
import '../../../../core/base/base_usecase.dart';
import '../../../../core/errors/failures.dart';
import '../entities/${FEATURE_NAME_LOWER}_entity.dart';
import '../repositories/${FEATURE_NAME_LOWER}_repository.dart';

class Get${FEATURE_NAME_PASCAL}sUseCase extends NoParamsUseCase<List<${FEATURE_NAME_PASCAL}Entity>> {
  final ${FEATURE_NAME_PASCAL}Repository repository;

  Get${FEATURE_NAME_PASCAL}sUseCase(this.repository);

  @override
  Future<Either<Failure, List<${FEATURE_NAME_PASCAL}Entity>>> call() async {
    return await repository.getAll();
  }
}
EOF

echo "✅ Created UseCase"

# Create Cubit
cat > "lib/features/$FEATURE_NAME_LOWER/presentation/cubit/${FEATURE_NAME_LOWER}_cubit.dart" << EOF
import '../../../../core/base/base_cubit.dart';
import '../../domain/entities/${FEATURE_NAME_LOWER}_entity.dart';
import '../../domain/usecases/get_${FEATURE_NAME_LOWER}s_usecase.dart';

part '${FEATURE_NAME_LOWER}_state.dart';

class ${FEATURE_NAME_PASCAL}Cubit extends BaseCubit {
  final Get${FEATURE_NAME_PASCAL}sUseCase get${FEATURE_NAME_PASCAL}sUseCase;

  ${FEATURE_NAME_PASCAL}Cubit({
    required this.get${FEATURE_NAME_PASCAL}sUseCase,
  }) : super(const InitialState());

  // State variables for pagination
  List<${FEATURE_NAME_PASCAL}Entity> items = [];
  int currentPage = 1;
  bool hasMore = true;
  bool isLoadingMore = false;

  /// Get all ${FEATURE_NAME_LOWER}s
  Future<void> get${FEATURE_NAME_PASCAL}s({bool refresh = false}) async {
    if (refresh) {
      items.clear();
      currentPage = 1;
      hasMore = true;
    }

    emitLoading();

    final result = await get${FEATURE_NAME_PASCAL}sUseCase();

    result.fold(
      (failure) => emitError(failure.message),
      (data) {
        items = data;
        if (items.isEmpty) {
          emitEmpty(message: 'لا توجد بيانات');
        } else {
          emit(${FEATURE_NAME_PASCAL}sLoadedState(items));
        }
      },
    );
  }

  /// Load more for pagination
  Future<void> loadMore() async {
    if (!hasMore || isLoadingMore) return;

    isLoadingMore = true;

    // TODO: Implement pagination with your UseCase
    // final result = await get${FEATURE_NAME_PASCAL}sUseCase(
    //   PaginationParams(page: currentPage + 1, limit: 20),
    // );

    // result.fold(
    //   (failure) {
    //     isLoadingMore = false;
    //     // Show error toast/snackbar
    //   },
    //   (response) {
    //     items.addAll(response.data);
    //     currentPage = response.nextPage ?? currentPage;
    //     hasMore = response.hasNextPage;
    //     isLoadingMore = false;
    //     emit(${FEATURE_NAME_PASCAL}sLoadedState(items));
    //   },
    // );
  }

  /// Refresh data
  Future<void> refresh() async {
    await get${FEATURE_NAME_PASCAL}s(refresh: true);
  }
}
EOF

# Create Cubit State
cat > "lib/features/$FEATURE_NAME_LOWER/presentation/cubit/${FEATURE_NAME_LOWER}_state.dart" << EOF
part of '${FEATURE_NAME_LOWER}_cubit.dart';

class ${FEATURE_NAME_PASCAL}sLoadedState extends SuccessState<List<${FEATURE_NAME_PASCAL}Entity>> {
  const ${FEATURE_NAME_PASCAL}sLoadedState(List<${FEATURE_NAME_PASCAL}Entity> data) : super(data);
}

class ${FEATURE_NAME_PASCAL}LoadedState extends SuccessState<${FEATURE_NAME_PASCAL}Entity> {
  const ${FEATURE_NAME_PASCAL}LoadedState(${FEATURE_NAME_PASCAL}Entity data) : super(data);
}
EOF

echo "✅ Created Cubit and States"

# Create Page
cat > "lib/features/$FEATURE_NAME_LOWER/presentation/pages/${FEATURE_NAME_LOWER}_page.dart" << EOF
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/base/base_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../cubit/${FEATURE_NAME_LOWER}_cubit.dart';

class ${FEATURE_NAME_PASCAL}Page extends StatelessWidget {
  const ${FEATURE_NAME_PASCAL}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<${FEATURE_NAME_PASCAL}Cubit>()..get${FEATURE_NAME_PASCAL}s(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('${FEATURE_NAME_PASCAL}s'),
        ),
        body: BlocBuilder<${FEATURE_NAME_PASCAL}Cubit, BaseState>(
          builder: (context, state) {
            final cubit = context.read<${FEATURE_NAME_PASCAL}Cubit>();

            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => cubit.refresh(),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            } else if (state is EmptyState) {
              return Center(
                child: Text(state.message ?? 'لا توجد بيانات'),
              );
            } else if (state is ${FEATURE_NAME_PASCAL}sLoadedState) {
              final items = state.data;
              return RefreshIndicator(
                onRefresh: () => cubit.refresh(),
                child: ListView.builder(
                  itemCount: items.length + (cubit.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    // Load more indicator
                    if (index == items.length) {
                      cubit.loadMore();
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final item = items[index];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text('ID: \${item.id}'),
                      // TODO: Add your UI
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<${FEATURE_NAME_PASCAL}Cubit>().refresh();
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
EOF

echo "✅ Created Page"

echo ""
echo "🎉 Feature with Cubit created successfully!"
echo ""
echo "📝 Next steps:"
echo "1. Register dependencies in service_locator.dart:"
echo "   - Register ${FEATURE_NAME_PASCAL}RemoteDataSource"
echo "   - Register ${FEATURE_NAME_PASCAL}Repository"
echo "   - Register Get${FEATURE_NAME_PASCAL}sUseCase"
echo "   - Register ${FEATURE_NAME_PASCAL}Cubit"
echo ""
echo "2. Add route in app_router.dart:"
echo "   GoRoute("
echo "     path: '/${FEATURE_NAME_LOWER}',"
echo "     builder: (context, state) => const ${FEATURE_NAME_PASCAL}Page(),"
echo "   )"
echo ""
echo "3. Update your entity and model with actual properties"
echo ""
echo "✨ Happy Coding with Cubit!"
