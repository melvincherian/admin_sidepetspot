//
// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:petspot_admin_side/firebase/category.dart';
import 'package:petspot_admin_side/infrastructure/pet_category_model.dart';

part 'category_event.dart';
part 'category_state.dart';

// category_bloc.dart

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc(this.categoryRepository) : super(CategoryInitial()) {
    on<AddcategoryEvent>(_onAddCategory);
  }

  Future<void> _onAddCategory(AddcategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      await categoryRepository.addCategory(event.category);
      emit(CategoryAddedsuccess());
    } catch (error) {
      emit(CategoryError('Failed to add category: $error'));
    }
  }

   
    Future<void> _onFetchCategories(FetchCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final categories = await categoryRepository.fetchCategories();
      emit(CategoriesFetched(categories));
    } catch (error) {
      emit(CategoryError('Failed to fetch categories: $error'));
    }
  }

  

}
