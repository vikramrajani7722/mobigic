
import '../../const/imports.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({super.key});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  TextEditingController rowController = TextEditingController();
  TextEditingController columnController = TextEditingController();
  TextEditingController alphabetController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxList<List<String>> grid = <List<String>>[].obs;
  RxInt rows = 0.obs, cols = 0.obs, multipliedRowCol = 0.obs;
  bool isAnyElementSearched = false;

  void createGrid() {
    int rowsInteger = int.tryParse(rowController.text) ?? 0;
    int colsInteger = int.tryParse(columnController.text) ?? 0;

    if (rowsInteger > 0 && colsInteger > 0) {
      rows.value = rowsInteger;
      cols.value = colsInteger;
      multipliedRowCol.value = rowsInteger * colsInteger;
      grid.value = List.generate(
          rowsInteger, (_) => List.generate(colsInteger, (_) => ''));
    }
  }

  void populateGrid() {
    final alphabets = alphabetController.text.toUpperCase().split(' ');

    if (alphabets.length == rows.value * cols.value) {
      setState(() {
        for (int i = 0; i < rows.value; i++) {
          for (int j = 0; j < cols.value; j++) {
            grid[i][j] = alphabets[i * cols.value + j];
          }
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Number of alphabets should be ${rows.value * cols.value}")),
      );
    }
  }

  void clearSelection() {
    rowController.clear();
    columnController.clear();
    alphabetController.clear();
    searchController.clear();
    grid.clear();
    rows.value = 0;
    cols.value = 0;
    multipliedRowCol.value = 0;
    isAnyElementSearched = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title:
            const Text("Mobigic Technologies", style: TextStyle(fontSize: 18)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
              onPressed: () {
                clearSelection();
              },
              child: const Text("Clear",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      color: Colors.black)))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: rowController,
                decoration: const InputDecoration(
                    labelText: 'Enter number of rows (m)'),
                maxLength: 2,
                keyboardType: TextInputType.number,
              ),
              15.heightBox,
              TextField(
                controller: columnController,
                decoration: const InputDecoration(
                    labelText: 'Enter number of columns (n)'),
                maxLength: 2,
                keyboardType: TextInputType.number,
              ),
              15.heightBox,
              Center(
                child: SizedBox(
                  width: Get.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      createGrid();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    child: const Text('Create Grid',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              15.heightBox,
              Obx(() => TextField(
                    controller: alphabetController,
                    decoration: InputDecoration(
                        labelText:
                            'Enter $multipliedRowCol alphabets (space-separated)'),
                  )),
              15.heightBox,
              Center(
                child: SizedBox(
                  width: Get.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      populateGrid();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    child: const Text('Populate Grid',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              15.heightBox,
              buildGridWidget(),
              15.heightBox,
              TextField(
                controller: searchController,
                decoration:
                    const InputDecoration(labelText: 'Enter text to search'),
              ),
              15.heightBox,
              Center(
                child: SizedBox(
                  width: Get.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      isAnyElementSearched = true;
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    child: const Text('Search Text',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridWidget() {
    return Obx(() => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(rows.value, (i) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(cols.value, (j) {
                    bool isHighlighted = isAnyElementSearched
                        ? findIsTextSearch(grid[i][j])
                        : false;
                    return Card(
                      shadowColor:
                          isHighlighted ? Colors.yellow : Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      margin: const EdgeInsets.all(4),
                      color: isHighlighted ? Colors.yellow : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4),
                        child: Text(
                          grid[i][j],
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
          ),
        ));
  }

  bool findIsTextSearch(String element) {
    if (searchController.text.toLowerCase() == element.toLowerCase()) {
      return true;
    } else {
      return false;
    }
  }
}
