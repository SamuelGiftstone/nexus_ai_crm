// lib/core/constants/app_strings.dart

abstract class AppStrings {
  // General / Window
  static const String appName = 'Nexus AI CRM';
  static const String appTagline = 'Enterprise Desktop Intelligence Suite';
  static const String globalSearchHint = 'Search contacts, deals, or ask AI...';

  // Startup / Splash
  static const String startupTitle = 'Nexus AI CRM';
  static const String startupSubTitle = 'Initializing enterprise workspace...';
  static const String startupStepWindow = 'Configuring Windows desktop environment...';
  static const String startupStepDatabase = 'Initializing SQLite local engine...';
  static const String startupStepSettings = 'Loading workspace preferences...';
  static const String startupStepOllama = 'Connecting to local Gemma AI engine...';
  static const String startupStepPrompts = 'Pre-caching prompt templates...';
  static const String startupComplete = 'Startup sequence completed.';

  // Navigation Items
  static const String navDashboard = 'Dashboard';
  static const String navContacts = 'Contacts';
  static const String navDuplicates = 'Duplicates';
  static const String navCopilot = 'AI Copilot';
  static const String navQuotations = 'Quotations';
  static const String navFollowups = 'Follow-ups';
  static const String navAnalytics = 'Analytics';
  static const String navSettings = 'Settings';

  // Dashboard Page
  static const String dashboardTitle = 'Business Overview';
  static const String dashboardSubtitle = 'Real-time pipeline metrics and AI sales recommendations.';
  static const String kpiTotalCustomers = 'Total Customers';
  static const String kpiActiveDeals = 'Active Deals';
  static const String kpiRevenue = 'Revenue';
  static const String kpiFollowups = 'Follow-ups Today';
  static const String kpiConversionRate = 'Conversion Rate';

  // Duplicates Page
  static const String duplicatesTitle = 'Duplicates Resolution';
  static const String duplicatesSearchHint = 'Show duplicated leads results...';
  static const String duplicatesMergeButton = 'Merge Duplicates';

  // AI Copilot Page
  static const String copilotTitle = 'AI Copilot Workspace';
  static const String copilotSubtitle = 'Local offline intelligence powered by Gemma LLM.';
  static const String copilotInputHint = 'Ask Nexus AI anything about your contacts, deals, or market trends...';
  static const String copilotReadyTitle = 'Ready to assist';
  static const String copilotReadyBody = 'Select a quick action or ask Gemma AI to analyze your CRM data.';

  // Quick Action Buttons
  static const String qaSummarize = 'Summarize Conversation';
  static const String qaQuotation = 'Generate Quotation';
  static const String qaReply = 'Generate Reply';
  static const String qaRisk = 'Analyze Customer Risk';
}