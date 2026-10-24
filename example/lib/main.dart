import 'package:flutter/material.dart';
import 'package:widgetarian/widgetarian.dart';
import 'models/package_item.dart';
import 'showcases/typography_showcases.dart';
import 'showcases/surfaces_showcases.dart';
import 'showcases/motion_showcases.dart';
import 'showcases/selection_showcases.dart';
import 'showcases/utility_showcases.dart';
import 'widgets/showcase_scaffold.dart';

void main() {
  runApp(const WidgetarianShowroomApp());
}

class WidgetarianShowroomApp extends StatelessWidget {
  const WidgetarianShowroomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemePatrol(
      themes: {
        'm3': ThemeConfig.withMode(
          description: 'Material 3',
          light: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
          ),
          dark: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          extensionsBuilder: [
            (context) => WxStaticSheetThemeM3(context),
            (context) => WxTapSheetThemeM3(context),
            (context) => WxToggleSheetThemeM3(context),
            (context) => WxButtonThemeM3(context),
            (context) => WxIconButtonThemeM3(context),
            (context) => WxCardThemeM3(context),
            (context) => WxCardTileThemeM3(context),
            (context) => WxChipThemeM3(context),
          ],
        ),
        'm2': ThemeConfig.withMode(
          description: 'Material 2',
          light: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.light,
            ),
            useMaterial3: false,
          ),
          dark: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.dark,
            ),
            useMaterial3: false,
          ),
          extensionsBuilder: [
            (context) => WxStaticSheetThemeM2(context),
            (context) => WxTapSheetThemeM2(context),
            (context) => WxToggleSheetThemeM2(context),
            (context) => WxButtonThemeM2(context),
            (context) => WxIconButtonThemeM2(context),
            (context) => WxCardThemeM2(context),
            (context) => WxCardTileThemeM2(context),
            (context) => WxChipThemeM2(context),
          ],
        ),
        'ios': ThemeConfig.withMode(
          description: 'iOS Cupertino',
          light: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.light,
            ),
            useMaterial3: false,
          ),
          dark: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.dark,
            ),
            useMaterial3: false,
          ),
          extensionsBuilder: [
            (context) => WxStaticSheetThemeIOS(context),
            (context) => WxTapSheetThemeIOS(context),
            (context) => WxToggleSheetThemeIOS(context),
            (context) => WxButtonThemeIOS(context),
            (context) => WxIconButtonThemeIOS(context),
            (context) => WxCardThemeIOS(context),
            (context) => WxCardTileThemeIOS(context),
            (context) => WxChipThemeIOS(context),
          ],
        ),
      },
      initialTheme: 'm3',
      initialMode: ThemeMode.system,
      builder: (context, theme, child) {
        return MaterialApp(
          title: 'Widgetarian Showroom',
          debugShowCheckedModeBanner: false,
          themeMode: theme.mode,
          theme: theme.lightData,
          darkTheme: theme.darkData,
          builder: theme.bootstrap(),
          home: const ShowroomMainShell(),
        );
      },
    );
  }
}

class ShowroomMainShell extends StatefulWidget {
  const ShowroomMainShell({super.key});

  @override
  State<ShowroomMainShell> createState() => _ShowroomMainShellState();
}

class _ShowroomMainShellState extends State<ShowroomMainShell> {
  PackageCategory _selectedCategory = PackageCategory.all;
  String _selectedPackageId = 'overview';
  String _searchQuery = '';

  late final List<PackageItem> _packages;

  @override
  void initState() {
    super.initState();
    _packages = [
      // Typography
      PackageItem(
        id: 'wx_text',
        name: 'wx_text',
        version: '4.0.0',
        summary: 'Declarative typography with outlines, gradient shaders, and pattern filters.',
        category: PackageCategory.typography,
        icon: Icons.text_fields_rounded,
        builder: (context) => const WxTextShowcase(),
      ),
      PackageItem(
        id: 'wx_text_animated',
        name: 'wx_text_animated',
        version: '1.0.0',
        summary: 'Animated text transitions: typewriter, shimmer, wave, and fade sweeps.',
        category: PackageCategory.typography,
        icon: Icons.auto_awesome_motion_rounded,
        builder: (context) => const WxTextAnimatedShowcase(),
      ),
      PackageItem(
        id: 'wx_spoiler',
        name: 'wx_spoiler',
        version: '1.0.0',
        summary: 'Interactive widget/image blur conceal & collapsible spoiler text.',
        category: PackageCategory.typography,
        icon: Icons.visibility_off_rounded,
        builder: (context) => const WxSpoilerShowcase(),
      ),

      // Surfaces & Layout
      PackageItem(
        id: 'wx_anchor',
        name: 'wx_anchor',
        version: '2.1.1',
        summary: 'Interactive touch and click anchor surface with visual feedback and event orchestration.',
        category: PackageCategory.surfaces,
        icon: Icons.ads_click_rounded,
        builder: (context) => const WxAnchorShowcase(),
      ),
      PackageItem(
        id: 'wx_box',
        name: 'wx_box',
        version: '4.2.1',
        summary: 'Unified declarative box container with linear/stadium borders and animations.',
        category: PackageCategory.surfaces,
        icon: Icons.check_box_outline_blank_rounded,
        builder: (context) => const WxBoxShowcase(),
      ),
      PackageItem(
        id: 'wx_divider',
        name: 'wx_divider',
        version: '1.0.0',
        summary: 'Dashed, dotted, and Morse code line patterns with embedded chips.',
        category: PackageCategory.surfaces,
        icon: Icons.horizontal_rule_rounded,
        builder: (context) => const WxDividerShowcase(),
      ),
      PackageItem(
        id: 'wx_tile',
        name: 'wx_tile',
        version: '2.0.0',
        summary: 'Highly customizable list tiles, text tiles, and animated tile wrappers.',
        category: PackageCategory.surfaces,
        icon: Icons.view_headline_rounded,
        builder: (context) => const WxTileShowcase(),
      ),
      PackageItem(
        id: 'wx_sheet',
        name: 'wx_sheet',
        version: '4.8.0',
        summary: 'Universal foundational container primitive combining box styling, touch anchors, tiles, and checkmarks.',
        category: PackageCategory.surfaces,
        icon: Icons.layers_outlined,
        builder: (context) => const WxSheetShowcase(),
      ),
      PackageItem(
        id: 'wx_button',
        name: 'wx_button',
        version: '2.0.4',
        summary: 'Adaptive button components, icon buttons, loading spinners, and multi-variant actions.',
        category: PackageCategory.surfaces,
        icon: Icons.smart_button_rounded,
        builder: (context) => const WxButtonShowcase(),
      ),
      PackageItem(
        id: 'wx_card',
        name: 'wx_card',
        version: '1.0.0',
        summary: 'Versatile surface cards and horizontal card tiles with header/footer composition.',
        category: PackageCategory.surfaces,
        icon: Icons.dashboard_outlined,
        builder: (context) => const WxCardShowcase(),
      ),
      PackageItem(
        id: 'wx_chip',
        name: 'wx_chip',
        version: '1.0.2',
        summary: 'Lightweight adaptive chips for filter toggling, tags, and action triggers.',
        category: PackageCategory.surfaces,
        icon: Icons.label_outline_rounded,
        builder: (context) => const WxChipShowcase(),
      ),
      PackageItem(
        id: 'wx_avatar',
        name: 'wx_avatar',
        version: '3.1.0',
        summary: 'Avatar system supporting initials, fallbacks, shapes, and badges.',
        category: PackageCategory.surfaces,
        icon: Icons.account_circle_rounded,
        builder: (context) => const WxAvatarShowcase(),
      ),
      PackageItem(
        id: 'wx_badge',
        name: 'wx_badge',
        version: '3.0.0',
        summary: 'Status indicators, notification counters, and positioned badge overlays.',
        category: PackageCategory.surfaces,
        icon: Icons.mark_chat_unread_rounded,
        builder: (context) => const WxBadgeShowcase(),
      ),
      PackageItem(
        id: 'fancy_border',
        name: 'fancy_border',
        version: '0.0.3',
        summary: 'Squircle, continuous curves, and custom styled vector border shapes.',
        category: PackageCategory.surfaces,
        icon: Icons.crop_square_rounded,
        builder: (context) => const FancyBorderShowcase(),
      ),
      PackageItem(
        id: 'overlap_stack',
        name: 'overlap_stack',
        version: '1.0.1',
        summary: 'Overlapping avatar facepiles and layered cards with +N overflow count.',
        category: PackageCategory.surfaces,
        icon: Icons.layers_rounded,
        builder: (context) => const OverlapStackShowcase(),
      ),

      // Motion
      PackageItem(
        id: 'animated_checkmark',
        name: 'animated_checkmark',
        version: '3.1.0',
        summary: 'Smooth animated vector checkmark and cross stroke painter.',
        category: PackageCategory.motion,
        icon: Icons.check_circle_outline_rounded,
        builder: (context) => const AnimatedCheckmarkShowcase(),
      ),
      PackageItem(
        id: 'animated_repeatable',
        name: 'animated_repeatable',
        version: '1.2.0',
        summary: 'Declarative looping micro-interactions: pulse, wobble, shake, and spin.',
        category: PackageCategory.motion,
        icon: Icons.loop_rounded,
        builder: (context) => const AnimatedRepeatableShowcase(),
      ),
      PackageItem(
        id: 'animated_switcher_transitions',
        name: 'animated_switcher_transitions',
        version: '1.0.0',
        summary: '15+ ready-to-use transitions for AnimatedSwitcher: flip, zoom, slide.',
        category: PackageCategory.motion,
        icon: Icons.transform_rounded,
        builder: (context) => const AnimatedSwitcherShowcase(),
      ),
      PackageItem(
        id: 'animated_transform',
        name: 'animated_transform',
        version: '1.0.6',
        summary: 'Implicit animated counterpart to Transform (scale, rotate, translate).',
        category: PackageCategory.motion,
        icon: Icons.open_with_rounded,
        builder: (context) => const AnimatedTransformShowcase(),
      ),
      PackageItem(
        id: 'animated_icon_theme',
        name: 'animated_icon_theme',
        version: '1.0.4',
        summary: 'Implicit smooth color, size, and opacity interpolation for icons.',
        category: PackageCategory.motion,
        icon: Icons.animation_rounded,
        builder: (context) => const AnimatedIconThemeShowcase(),
      ),
      PackageItem(
        id: 'marquee_transition',
        name: 'marquee_transition',
        version: '0.1.0',
        summary: 'Continuous scrolling marquee ticker with configurable speed and loop.',
        category: PackageCategory.motion,
        icon: Icons.view_carousel_rounded,
        builder: (context) => const MarqueeTransitionShowcase(),
      ),

      // Selection & Pickers
      PackageItem(
        id: 'choice',
        name: 'choice',
        version: '2.3.3',
        summary: 'Clean selection framework for inline chips, modal dialogs, and sheets.',
        category: PackageCategory.pickers,
        icon: Icons.tune_rounded,
        builder: (context) => const ChoiceShowcase(),
      ),
      PackageItem(
        id: 'wheel_choice',
        name: 'wheel_choice',
        version: '1.3.0',
        summary: '3D cylindrical wheel picker with magnification lens and inertial scroll.',
        category: PackageCategory.pickers,
        icon: Icons.touch_app_rounded,
        builder: (context) => const WheelChoiceShowcase(),
      ),
      PackageItem(
        id: 'wheel_choice_ext',
        name: 'wheel_choice_ext',
        version: '0.1.0',
        summary: 'Cascading wheels, locale-aware date pickers, and time selectors.',
        category: PackageCategory.pickers,
        icon: Icons.date_range_rounded,
        builder: (context) => const WheelChoiceExtShowcase(),
      ),
      PackageItem(
        id: 'disclosure',
        name: 'disclosure',
        version: '2.2.0',
        summary: 'Headless, accessible collapsible accordions with customizable headers.',
        category: PackageCategory.pickers,
        icon: Icons.unfold_more_rounded,
        builder: (context) => const DisclosureShowcase(),
      ),

      // Utilities & State
      PackageItem(
        id: 'gacha',
        name: 'gacha',
        version: '1.0.0',
        summary: 'Lightweight random & mock data generation library with seedable PRNG.',
        category: PackageCategory.utilities,
        icon: Icons.casino_rounded,
        builder: (context) => const GachaShowcase(),
      ),
      PackageItem(
        id: 'chronograph',
        name: 'chronograph',
        version: '1.0.2',
        summary: 'Precision stopwatch and countdown timer engine powered by ValueListenable.',
        category: PackageCategory.utilities,
        icon: Icons.timer_outlined,
        builder: (context) => const ChronographShowcase(),
      ),
      PackageItem(
        id: 'theme_patrol',
        name: 'theme_patrol',
        version: '3.2.3',
        summary: 'Multi-theme manager supporting design system presets, color schemes, and theme modes.',
        category: PackageCategory.utilities,
        icon: Icons.palette_outlined,
        builder: (context) => const ThemePatrolShowcase(),
      ),
      PackageItem(
        id: 'widget_driven',
        name: 'widget_driven',
        version: '1.0.0',
        summary: 'Reactive event-driven widgets, builders, spinners, and animated transitions based on WidgetEvents.',
        category: PackageCategory.utilities,
        icon: Icons.dynamic_feed_rounded,
        builder: (context) => const WidgetDrivenShowcase(),
      ),
      PackageItem(
        id: 'widget_event',
        name: 'widget_event',
        version: '2.0.1',
        summary: 'Extensible event-driven state orchestration with built-in loading and driven resolvers.',
        category: PackageCategory.utilities,
        icon: Icons.hub_rounded,
        builder: (context) => const WidgetEventShowcase(),
      ),
      PackageItem(
        id: 'wx_utils',
        name: 'wx_utils',
        version: '0.0.5',
        summary: 'Core shared utilities for color blending, lightness, and contrast.',
        category: PackageCategory.utilities,
        icon: Icons.color_lens_outlined,
        builder: (context) => const WxUtilsShowcase(),
      ),
      PackageItem(
        id: 'lerp',
        name: 'lerp',
        version: '0.0.2',
        summary: 'Generic value interpolation functions: lerpInt, lerpBool, and lerpEnum.',
        category: PackageCategory.utilities,
        icon: Icons.linear_scale_rounded,
        builder: (context) => const LerpShowcase(),
      ),
    ];
  }

  List<PackageItem> get _filteredPackages {
    return _packages.where((pkg) {
      final matchesCategory = _selectedCategory == PackageCategory.all || pkg.category == _selectedCategory;
      final matchesQuery = _searchQuery.isEmpty ||
          pkg.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          pkg.summary.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeController = ThemeProvider.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 850;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.surface,
                theme.colorScheme.surfaceContainerHighest.withAlpha(120),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border(
              bottom: BorderSide(
                color: theme.colorScheme.outlineVariant.withAlpha(90),
                width: 1,
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.widgets_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Text(
              'Widgetarian Showroom',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -0.5),
            ),
          ],
        ),
        actions: [
          // Theme Preset: M3 / M2 / iOS
          if (isDesktop)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SegmentedButton<String>(
                showSelectedIcon: false,
                style: const ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                segments: const [
                  ButtonSegment(
                    value: 'm3',
                    label: Text('M3'),
                    tooltip: 'Material 3 Preset',
                  ),
                  ButtonSegment(
                    value: 'm2',
                    label: Text('M2'),
                    tooltip: 'Material 2 Preset',
                  ),
                  ButtonSegment(
                    value: 'ios',
                    label: Text('iOS'),
                    tooltip: 'iOS Cupertino Preset',
                  ),
                ],
                selected: {themeController.selected},
                onSelectionChanged: (state) => themeController.select(state.first),
              ),
            )
          else
            PopupMenuButton<String>(
              tooltip: 'Design System Preset',
              icon: const Icon(Icons.style_rounded),
              initialValue: themeController.selected,
              onSelected: (val) => themeController.select(val),
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'm3', child: Text('Material 3')),
                PopupMenuItem(value: 'm2', child: Text('Material 2')),
                PopupMenuItem(value: 'ios', child: Text('iOS Cupertino')),
              ],
            ),
          const SizedBox(width: 6),

          // Theme Preset: Color Palette Presets
          PopupMenuButton<Color>(
            tooltip: 'Color Palette Presets',
            icon: const Icon(Icons.palette_outlined),
            onSelected: (color) => themeController.toColor(color),
            itemBuilder: (context) {
              const presets = [
                MapEntry('Deep Purple', Colors.deepPurple),
                MapEntry('Indigo', Colors.indigo),
                MapEntry('Teal', Colors.teal),
                MapEntry('Emerald', Colors.green),
                MapEntry('Sunset Amber', Colors.deepOrange),
                MapEntry('Rose Berry', Colors.pink),
                MapEntry('Ocean Cyan', Colors.cyan),
              ];
              final currentColor = themeController.color ?? Colors.deepPurple;
              return presets.map((entry) {
                final isSelected = currentColor.toARGB32() == entry.value.toARGB32();
                return PopupMenuItem<Color>(
                  value: entry.value,
                  child: Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: entry.value,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.outlineVariant,
                            width: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(entry.key)),
                      if (isSelected)
                        Icon(
                          Icons.check_rounded,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),
                    ],
                  ),
                );
              }).toList();
            },
          ),

          // Theme Mode Toggle (Light / Dark / System)
          IconButton(
            tooltip: 'Theme Mode (${themeController.mode.name})',
            icon: Icon(themeController.modeIcon),
            onPressed: themeController.toggleMode,
          ),

          IconButton(
            tooltip: 'GitHub Repository',
            icon: const Icon(Icons.code_rounded),
            onPressed: () => openURL('https://github.com/davigmacode/flutter_wx'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: isDesktop ? _buildDesktopLayout(theme) : _buildMobileLayout(theme),
    );
  }

  Widget _buildDesktopLayout(ThemeData theme) {
    return Row(
      children: [
        // Sidebar Package Navigation
        SizedBox(
          width: 300,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search ${_packages.length} packages...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    isDense: true,
                    filled: true,
                    fillColor: theme.colorScheme.surfaceContainerHighest.withAlpha(80),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (val) => setState(() => _searchQuery = val),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: PackageCategory.values.map((cat) {
                    final isSel = _selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: FilterChip(
                        label: Text(cat.label.split(' ')[0]),
                        selected: isSel,
                        onSelected: (val) {
                          if (val) setState(() => _selectedCategory = cat);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.dashboard_rounded),
                      title: const Text('Overview', style: TextStyle(fontWeight: FontWeight.bold)),
                      selected: _selectedPackageId == 'overview',
                      onTap: () => setState(() => _selectedPackageId = 'overview'),
                    ),
                    const Divider(height: 1),
                    ..._filteredPackages.map((pkg) {
                      final isSelected = _selectedPackageId == pkg.id;
                      return ListTile(
                        leading: Icon(pkg.icon, size: 20),
                        title: Text(pkg.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text(pkg.version, style: const TextStyle(fontSize: 11)),
                        selected: isSelected,
                        dense: true,
                        onTap: () => setState(() => _selectedPackageId = pkg.id),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
        const VerticalDivider(width: 1),
        // Content Area
        Expanded(
          child: _selectedPackageId == 'overview'
              ? _buildOverviewDashboard(theme)
              : _packages.firstWhere((p) => p.id == _selectedPackageId).builder(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(ThemeData theme) {
    if (_selectedPackageId != 'overview') {
      final selectedPkg = _packages.firstWhere((p) => p.id == _selectedPackageId);
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            setState(() => _selectedPackageId = 'overview');
          }
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: theme.colorScheme.surfaceContainerHighest.withAlpha(60),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => setState(() => _selectedPackageId = 'overview'),
                  ),
                  Text('Back to Catalog', style: theme.textTheme.titleMedium),
                ],
              ),
            ),
            Expanded(child: selectedPkg.builder(context)),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search packages...',
              prefixIcon: const Icon(Icons.search_rounded),
              isDense: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: (val) => setState(() => _searchQuery = val),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredPackages.length,
            itemBuilder: (context, i) {
              final pkg = _filteredPackages[i];
              return ListTile(
                leading: Icon(pkg.icon),
                title: Text(pkg.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(pkg.summary, maxLines: 1, overflow: TextOverflow.ellipsis),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => setState(() => _selectedPackageId = pkg.id),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewDashboard(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Banner
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primaryContainer.withAlpha(140),
                      colorScheme.tertiaryContainer.withAlpha(80),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: colorScheme.outlineVariant.withAlpha(80)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'UMBRELLA V1.0.0',
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text('Unified Monorepo Architecture', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const WxText.displaySmall(
                      'The Widgetarian UI Toolkit',
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Explore 26 composable Flutter packages spanning typography, animations, selection sheets, custom pickers, event state orchestration, and layout tiles under one ecosystem.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _buildStatChip(Icons.inventory_2_rounded, '29 Modular Packages'),
                        _buildStatChip(Icons.check_circle_rounded, '100% Test Pass Rate'),
                        _buildStatChip(Icons.verified_rounded, '0 Analyzer Warnings'),
                        _buildStatChip(Icons.speed_rounded, 'Zero External Overhead'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              Text(
                'Browse Packages by Pillar',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 700 ? 3 : 2;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: _packages.length,
                    itemBuilder: (context, i) {
                      final pkg = _packages[i];
                      return InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => setState(() => _selectedPackageId = pkg.id),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: colorScheme.outlineVariant.withAlpha(80)),
                            color: colorScheme.surface,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(pkg.icon, color: colorScheme.primary, size: 22),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      pkg.name,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    pkg.version,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: colorScheme.onSurfaceVariant,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: Text(
                                  pkg.summary,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colorScheme.onSurfaceVariant,
                                    height: 1.4,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withAlpha(180),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}
