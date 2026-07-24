# Nexus AI CRM

> An Offline AI-Powered Customer Relationship Management (CRM) Desktop Application built with Flutter and Google's Gemma Open Model.

---

# Overview

Nexus AI CRM is a modern Windows desktop CRM that combines customer relationship management with on-device artificial intelligence powered by Google's Gemma model.

Unlike traditional cloud-based CRMs, Nexus AI CRM is designed to work entirely offline, making it suitable for businesses operating in low-connectivity environments. The application helps businesses manage customers, quotations, follow-ups, sales opportunities, and business insights while using AI to automate repetitive tasks and improve productivity.

The AI runs locally through Ollama, ensuring business data remains private and secure.

---

# Problem Statement

Many small and medium-sized businesses struggle with:

- Poor customer record management
- Duplicate customer records
- Manual quotation writing
- Missed customer follow-ups
- Limited access to AI due to poor internet connectivity
- Expensive cloud CRM subscriptions
- Data privacy concerns

Nexus AI CRM addresses these challenges by providing an intelligent offline CRM powered by Google's Gemma.

---

# Solution

Nexus AI CRM integrates Google's Gemma open model directly into a desktop CRM.

The AI assists users by:

- Summarizing customer interactions
- Drafting professional quotations
- Generating follow-up messages
- Detecting duplicate customer records
- Answering business questions
- Providing sales insights
- Improving business productivity

Since everything runs locally through Ollama, businesses can continue working even without an internet connection.

---

# Features

## Dashboard

- Business overview
- Customer statistics
- Sales overview
- Revenue analytics
- Recent activities
- AI recommendations

---

## Contact Management

- Create customers
- Edit customers
- Delete customers
- Customer notes
- Phone numbers
- Email addresses
- Company information
- Customer tags
- Search contacts

---

## Companies

- Company profiles
- Contact persons
- Industry classification
- Business information

---

## Quotations

- Create quotations
- AI-assisted quotation writing
- Product pricing
- Discount calculations
- Professional quotation templates
- PDF export (planned)

---

## Follow-ups

- Schedule reminders
- Customer follow-ups
- Priority tracking
- Completed tasks
- Upcoming reminders

---

## Duplicate Manager

- Detect duplicate customers
- Merge duplicate records
- AI duplicate suggestions
- Data cleanup

---

## AI Copilot

The embedded AI assistant powered by Google's Gemma can:

- Summarize customer conversations
- Generate quotations
- Write follow-up emails
- Draft WhatsApp messages
- Suggest next customer actions
- Answer CRM-related questions
- Analyze sales performance
- Recommend business improvements

---

## Analytics

- Sales performance
- Customer growth
- Revenue tracking
- Conversion rates
- AI-generated business insights

---

# Offline AI

One of the primary goals of this project is to demonstrate how AI can remain useful even without internet access.

Google's Gemma model runs locally using Ollama.

Benefits include:

- Offline AI
- Fast response times
- Improved privacy
- Local data processing
- No cloud dependency

---

# Technology Stack

## Framework

- Flutter (Windows Desktop)

## Programming Language

- Dart

## Artificial Intelligence

- Google Gemma Open Model
- Ollama

## State Management

- Provider (planned)

## Local Database

- Isar Database (planned)

## Desktop Platform

- Windows

## Networking

- HTTP Package

---

# Project Architecture

```
Flutter UI

        │

        ▼

AI Manager

        │

        ▼

Prompt Builder

        │

        ▼

Ollama Service

        │

        ▼

Google Gemma

        │

        ▼

Local Business Intelligence
```

---

# How Gemma is Used

Google's Gemma serves as the intelligent assistant inside Nexus AI CRM.

Rather than acting as a general chatbot, Gemma is integrated into everyday business workflows.

Examples include:

- Customer summaries
- Quotation generation
- Follow-up generation
- CRM search assistance
- Business analytics
- Sales recommendations
- Duplicate record detection
- Professional business writing

---

# Why Gemma?

Gemma enables:

- Local inference
- Offline AI
- Privacy-focused deployment
- Fast business assistance
- Reliable AI without internet

This aligns perfectly with the hackathon's focus on offline and low-connectivity AI applications.

---

# Future Improvements

- Invoice generation
- Inventory management
- Customer segmentation
- Email integration
- WhatsApp integration
- Calendar synchronization
- Multi-user support
- Cloud synchronization
- Voice AI assistant
- AI workflow automation

---

# Installation

## Clone Repository

```bash
git clone https://github.com/YOUR_USERNAME/nexus-ai-crm.git
```

## Install Flutter Packages

```bash
flutter pub get
```

## Install Ollama

Download Ollama from:

https://ollama.com

---

## Download Gemma

```bash
ollama pull gemma3:1b
```

---

## Run Flutter Desktop

```bash
flutter run -d windows
```

---

# Target Users

- Small Businesses
- Medium Businesses
- Sales Teams
- Business Owners
- Customer Support Teams
- Freelancers
- Startups

---

# Hackathon Category

Productivity & Community Impact

---

# Built With

- Flutter
- Dart
- Google Gemma
- Ollama
- Material Design 3

---

# License

This project is open source and was created for the **Build with Gemma: GDG on Campus LASU Hackathon 2026**.

---

# Acknowledgements

- Google Gemma Team
- Google Developer Groups on Campus LASU
- Kaggle
- Flutter Team
- Ollama Team

---

# Author

**Samuel Giftstone**

Build with Gemma Hackathon 2026
